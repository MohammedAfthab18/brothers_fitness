import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/timestamp_converters.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// Admin / staff user of the Brothers Fitness desktop app.
///
/// Avatars are stored inline as compressed base64 strings to avoid
/// Firebase Storage and extra reads.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    /// Firestore document id (client-generated or same as auth uid).
    required String id,

    required String displayName,
    required String email,

    /// Role: owner, admin, staff, etc.
    required String role,

    /// Fine-grained permissions, e.g. members:rw, payments:r.
    @Default(<String>[]) List<String> permissions,

    /// Optional base64-encoded avatar image.
    String? photoBase64,

    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @NullableTimestampConverter() DateTime? lastSyncedAt,
    @Default(false) bool isSynced,
  }) = _AppUser;

  const AppUser._();

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

extension AppUserFirestoreX on AppUser {
  static AppUser fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing user data for id ${doc.id}');
    }
    return AppUser.fromJson(<String, dynamic>{...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }
}