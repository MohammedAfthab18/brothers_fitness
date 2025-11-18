import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/member/member.dart';
import '../../services/firebase/firestore_service.dart';
import '../local/cache_datasource.dart';

class MemberRemoteDataSource {
  MemberRemoteDataSource(this._firestoreService, this._cacheDatasource);

  final FirestoreService _firestoreService;
  final CacheDatasource _cacheDatasource;

  static const _collectionPath = 'members';
  static const _listCacheKey = 'members:list';

  Future<Member?> getMemberById(String id, {bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await _cacheDatasource.getById<Member>(
        collection: _collectionPath,
        id: id,
      );
      if (cached != null) {
        return cached;
      }
    }

    final member = await _firestoreService.getDocument<Member>(
      path: '$_collectionPath/$id',
      fromJson: Member.fromJson,
      forceRefresh: forceRefresh,
    );

    if (member != null) {
      await _cacheDatasource.cacheModel<Member>(
        collection: _collectionPath,
        model: member,
      );
    }

    return member;
  }

  Future<List<Member>> getMembers({
    bool forceRefresh = false,
    String? cacheKey,
    Query<Map<String, dynamic>> Function(
      CollectionReference<Map<String, dynamic>>,
    )?
    queryBuilder,
  }) {
    final resolvedCacheKey = cacheKey ?? _listCacheKey;
    return _cacheDatasource.fetchList<Member>(
      cacheKey: resolvedCacheKey,
      forceRefresh: forceRefresh,
      remoteCall: () async {
        final members = await _firestoreService.getCollection<Member>(
          path: _collectionPath,
          fromJson: Member.fromJson,
          queryBuilder: queryBuilder,
        );
        await _cacheDatasource.cacheMany<Member>(
          collection: _collectionPath,
          models: members,
        );
        return members;
      },
    );
  }

  Future<void> createMember(Member member) async {
    try {
      await _firestoreService.setDocument(
        path: '$_collectionPath/${member.id}',
        data: member.toFirestore(),
      );
      await _cacheDatasource.cacheModel<Member>(
        collection: _collectionPath,
        model: member,
      );
      await _cacheDatasource.invalidateList(_listCacheKey);
    } on AppException {
      rethrow;
    }
  }

  Future<void> updateMember(Member member) async {
    try {
      await _firestoreService.updateDocument(
        path: '$_collectionPath/${member.id}',
        data: member.toFirestore(),
      );
      await _cacheDatasource.cacheModel<Member>(
        collection: _collectionPath,
        model: member,
      );
      await _cacheDatasource.invalidateList(_listCacheKey);
    } on AppException {
      rethrow;
    }
  }

  Future<void> deleteMember(String id) async {
    await _firestoreService.deleteDocument('$_collectionPath/$id');
    await _cacheDatasource.removeById(_collectionPath, id);
    await _cacheDatasource.invalidateList(_listCacheKey);
  }
}

final memberRemoteDataSourceProvider = Provider<MemberRemoteDataSource>((ref) {
  final firestore = ref.watch(firestoreServiceProvider);
  final cache = ref.watch(cacheDatasourceProvider);
  return MemberRemoteDataSource(firestore, cache);
});
