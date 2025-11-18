// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Member _$MemberFromJson(Map<String, dynamic> json) => _Member(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  phone: json['phone'] as String,
  whatsappNumber: json['whatsappNumber'] as String,
  status: json['status'] as String,
  planId: json['planId'] as String,
  planName: json['planName'] as String,
  planPrice: (json['planPrice'] as num).toDouble(),
  planDurationDays: (json['planDurationDays'] as num).toInt(),
  lastPaidAmount: (json['lastPaidAmount'] as num).toDouble(),
  lastPaidDate: const TimestampConverter().fromJson(json['lastPaidDate']),
  expiryDate: const TimestampConverter().fromJson(json['expiryDate']),
  attendanceCount: (json['attendanceCount'] as num?)?.toInt() ?? 0,
  photoBase64: json['photoBase64'] as String?,
  notes:
      (json['notes'] as List<dynamic>?)
          ?.map((e) => MemberNoteBlock.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MemberNoteBlock>[],
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  lastSyncedAt: const NullableTimestampConverter().fromJson(
    json['lastSyncedAt'],
  ),
  isSynced: json['isSynced'] as bool? ?? false,
);

Map<String, dynamic> _$MemberToJson(_Member instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'phone': instance.phone,
  'whatsappNumber': instance.whatsappNumber,
  'status': instance.status,
  'planId': instance.planId,
  'planName': instance.planName,
  'planPrice': instance.planPrice,
  'planDurationDays': instance.planDurationDays,
  'lastPaidAmount': instance.lastPaidAmount,
  'lastPaidDate': const TimestampConverter().toJson(instance.lastPaidDate),
  'expiryDate': const TimestampConverter().toJson(instance.expiryDate),
  'attendanceCount': instance.attendanceCount,
  'photoBase64': instance.photoBase64,
  'notes': instance.notes.map((e) => e.toJson()).toList(),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'lastSyncedAt': const NullableTimestampConverter().toJson(
    instance.lastSyncedAt,
  ),
  'isSynced': instance.isSynced,
};

_MemberNoteBlock _$MemberNoteBlockFromJson(Map<String, dynamic> json) =>
    _MemberNoteBlock(
      id: json['id'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const NullableTimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$MemberNoteBlockToJson(
  _MemberNoteBlock instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'content': instance.content,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const NullableTimestampConverter().toJson(instance.updatedAt),
};
