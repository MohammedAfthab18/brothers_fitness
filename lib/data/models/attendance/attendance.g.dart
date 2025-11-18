// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Attendance _$AttendanceFromJson(Map<String, dynamic> json) => _Attendance(
  id: json['id'] as String,
  memberId: json['memberId'] as String,
  memberName: json['memberName'] as String,
  date: json['date'] as String,
  checkInTime: const TimestampConverter().fromJson(json['checkInTime']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  lastSyncedAt: const NullableTimestampConverter().fromJson(
    json['lastSyncedAt'],
  ),
  isSynced: json['isSynced'] as bool? ?? false,
);

Map<String, dynamic> _$AttendanceToJson(_Attendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'date': instance.date,
      'checkInTime': const TimestampConverter().toJson(instance.checkInTime),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'lastSyncedAt': const NullableTimestampConverter().toJson(
        instance.lastSyncedAt,
      ),
      'isSynced': instance.isSynced,
    };
