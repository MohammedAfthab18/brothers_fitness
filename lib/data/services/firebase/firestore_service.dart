import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/exceptions.dart';
import '../local/cache_service.dart';

class FirestoreService {
  FirestoreService({
    FirebaseFirestore? firestore,
    required CacheService cacheService,
    this.defaultCacheTtl = const Duration(minutes: 5),
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _cacheService = cacheService {
    _firestore.settings = const Settings(persistenceEnabled: true);
  }

  final FirebaseFirestore _firestore;
  final CacheService _cacheService;
  final Duration defaultCacheTtl;

  Future<T?> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    Duration? ttl,
    bool forceRefresh = false,
  }) async {
    final cacheKey = _documentCacheKey(path);
    if (!forceRefresh) {
      final cached = await _cacheService.load(cacheKey);
      if (cached != null) {
        return fromJson(cached);
      }
    }

    try {
      final snapshot = await _firestore.doc(path).get();
      final data = snapshot.data();
      if (data == null) {
        return null;
      }
      final json = Map<String, dynamic>.from(data)
        ..putIfAbsent('id', () => snapshot.id);
      await _cacheService.save(cacheKey, json, ttl: ttl ?? defaultCacheTtl);
      return fromJson(json);
    } on FirebaseException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    } catch (error, stackTrace) {
      throw AppException(
        message: 'Failed to read document at $path',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    Query<Map<String, dynamic>> Function(
      CollectionReference<Map<String, dynamic>>,
    )?
    queryBuilder,
  }) async {
    try {
      final collection = _firestore.collection(path);
      final query = queryBuilder?.call(collection) ?? collection;
      final snapshot = await query.get();
      return snapshot.docs
          .map(
            (doc) => fromJson(
              Map<String, dynamic>.from(doc.data())
                ..putIfAbsent('id', () => doc.id),
            ),
          )
          .toList();
    } on FirebaseException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    } catch (error, stackTrace) {
      throw AppException(
        message: 'Failed to read collection $path',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> setDocument({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final docRef = _firestore.doc(path);
    try {
      await docRef.set(data, SetOptions(merge: merge));
      final payload = Map<String, dynamic>.from(data);
      payload.putIfAbsent('id', () => docRef.id);
      await _cacheService.save(_documentCacheKey(path), payload);
    } on FirebaseException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    }
  }

  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final docRef = _firestore.doc(path);
    try {
      await docRef.update(data);

      final cached =
          await _cacheService.load(_documentCacheKey(path)) ??
          <String, dynamic>{'id': docRef.id};
      cached.addAll(data);
      await _cacheService.save(_documentCacheKey(path), cached);
    } on FirebaseException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    }
  }

  Future<void> deleteDocument(String path) async {
    try {
      await _firestore.doc(path).delete();
      await _cacheService.remove(_documentCacheKey(path));
    } on FirebaseException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    }
  }

  Future<T> runTransaction<T>(
    Future<T> Function(Transaction transaction) action,
  ) {
    return _firestore.runTransaction(action);
  }

  FieldValue serverTimestamp() => FieldValue.serverTimestamp();

  String _documentCacheKey(String path) => 'firestore:$path';
}

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  final cacheService = ref.watch(cacheServiceProvider);
  return FirestoreService(cacheService: cacheService);
});
