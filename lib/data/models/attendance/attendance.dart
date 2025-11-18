import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/timestamp_converters.dart';

part 'attendance.freezed.dart';
part 'attendance.g.dart';

/// Attendance entry keyed by `memberId_yyyymmdd`.
///
/// This idempotent id avoids duplicate check-ins without requiring
/// Firestore transactions and keeps the collection flat.
@freezed
class Attendance with _$Attendance {
  @JsonSerializable(explicitToJson: true)
  const factory Attendance({
    /// Firestore document id: `memberId_yyyymmdd`.
    required String id,

    /// Member reference.
    required String memberId,

    /// Denormalized member name for quick reporting.
    required String memberName,

    /// Logical attendance date (local YYYY-MM-DD).
    required String date,

    /// Exact check-in timestamp.
    @TimestampConverter() required DateTime checkInTime,

    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @NullableTimestampConverter() DateTime? lastSyncedAt,
    @Default(false) bool isSynced,
  }) = _Attendance;

  const Attendance._();

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
}

extension AttendanceFirestoreX on Attendance {
  static Attendance fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing attendance data for id ${doc.id}');
    }
    return Attendance.fromJson(<String, dynamic>{...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }
}


