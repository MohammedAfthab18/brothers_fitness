// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reminder _$ReminderFromJson(Map<String, dynamic> json) => _Reminder(
  id: json['id'] as String,
  memberId: json['memberId'] as String,
  memberName: json['memberName'] as String,
  whatsappNumber: json['whatsappNumber'] as String,
  planName: json['planName'] as String,
  expiryDate: const TimestampConverter().fromJson(json['expiryDate']),
  reminderType: json['reminderType'] as String,
  channel: json['channel'] as String,
  isSent: json['isSent'] as bool? ?? false,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  lastSyncedAt: const NullableTimestampConverter().fromJson(
    json['lastSyncedAt'],
  ),
  isSynced: json['isSynced'] as bool? ?? false,
);

Map<String, dynamic> _$ReminderToJson(_Reminder instance) => <String, dynamic>{
  'id': instance.id,
  'memberId': instance.memberId,
  'memberName': instance.memberName,
  'whatsappNumber': instance.whatsappNumber,
  'planName': instance.planName,
  'expiryDate': const TimestampConverter().toJson(instance.expiryDate),
  'reminderType': instance.reminderType,
  'channel': instance.channel,
  'isSent': instance.isSent,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'lastSyncedAt': const NullableTimestampConverter().toJson(
    instance.lastSyncedAt,
  ),
  'isSynced': instance.isSynced,
};
