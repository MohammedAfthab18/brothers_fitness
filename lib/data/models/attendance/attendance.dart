import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../common/timestamp_converters.dart';

part 'attendance.freezed.dart';
part 'attendance.g.dart';

@freezed
abstract class Attendance with _$Attendance {
  const factory Attendance({
    required String id,
    required String memberId,

    @TimestampConverter() required DateTime date,
    @TimestampConverter() required DateTime checkInTime,
    @NullableTimestampConverter() DateTime? checkOutTime,

    @TimestampConverter() required DateTime createdAt,
  }) = _Attendance;

  // ignore: unused_element
  const Attendance._();

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
}

extension AttendanceFirestoreX on Attendance {
  static Attendance fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
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
