import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/exceptions.dart';

class StorageService {
  StorageService({FirebaseStorage? storage})
    : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  Future<String> uploadFile({
    required String path,
    required Uint8List data,
    String? contentType,
    Map<String, String>? metadata,
  }) async {
    try {
      final ref = _storage.ref(path);
      await ref.putData(
        data,
        SettableMetadata(contentType: contentType, customMetadata: metadata),
      );
      return ref.getDownloadURL();
    } on FirebaseException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      await _storage.ref(path).delete();
    } on FirebaseException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    }
  }

  Future<String> getFileUrl(String path) async {
    try {
      return _storage.ref(path).getDownloadURL();
    } on FirebaseException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    }
  }
}

final storageServiceProvider = Provider<StorageService>(
  (ref) => StorageService(),
);
