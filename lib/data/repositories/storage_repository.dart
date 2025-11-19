import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/firebase/storage_service.dart';

/// Repository for Firebase Storage operations (member photos).
class StorageRepository {
  StorageRepository(this._storageService);

  final StorageService _storageService;

  static const String _memberPhotosPath = 'member_photos';

  /// Upload a member photo.
  ///
  /// Returns the download URL of the uploaded file.
  Future<String> uploadMemberPhoto({
    required String memberId,
    required Uint8List imageData,
    String? contentType,
  }) async {
    final path = '$_memberPhotosPath/$memberId.jpg';
    return _storageService.uploadFile(
      path: path,
      data: imageData,
      contentType: contentType ?? 'image/jpeg',
      metadata: {
        'memberId': memberId,
        'uploadedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Delete a member photo.
  Future<void> deleteMemberPhoto(String memberId) async {
    final path = '$_memberPhotosPath/$memberId.jpg';
    return _storageService.deleteFile(path);
  }

  /// Get the download URL for a member photo.
  Future<String?> getMemberPhotoUrl(String memberId) async {
    try {
      final path = '$_memberPhotosPath/$memberId.jpg';
      return _storageService.getFileUrl(path);
    } catch (_) {
      return null;
    }
  }
}

final storageRepositoryProvider = Provider<StorageRepository>((ref) {
  final storageService = ref.read(storageServiceProvider);
  return StorageRepository(storageService);
});
