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

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
}
