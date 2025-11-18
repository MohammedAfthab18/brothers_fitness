// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Attendance _$AttendanceFromJson(Map<String, dynamic> json) => _Attendance(
  id: json['id'] as String,
  memberId: json['memberId'] as String,
  date: const TimestampConverter().fromJson(json['date']),
  checkInTime: const TimestampConverter().fromJson(json['checkInTime']),
  checkOutTime: const NullableTimestampConverter().fromJson(
    json['checkOutTime'],
  ),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$AttendanceToJson(_Attendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'date': const TimestampConverter().toJson(instance.date),
      'checkInTime': const TimestampConverter().toJson(instance.checkInTime),
      'checkOutTime': const NullableTimestampConverter().toJson(
        instance.checkOutTime,
      ),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
