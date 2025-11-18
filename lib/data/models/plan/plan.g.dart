// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Plan _$PlanFromJson(Map<String, dynamic> json) => _Plan(
  id: json['id'] as String,
  title: json['title'] as String,
  durationDays: (json['durationDays'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  isActive: json['isActive'] as bool? ?? true,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  lastSyncedAt: const NullableTimestampConverter().fromJson(
    json['lastSyncedAt'],
  ),
  isSynced: json['isSynced'] as bool? ?? false,
);

Map<String, dynamic> _$PlanToJson(_Plan instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'durationDays': instance.durationDays,
  'price': instance.price,
  'isActive': instance.isActive,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'lastSyncedAt': const NullableTimestampConverter().toJson(
    instance.lastSyncedAt,
  ),
  'isSynced': instance.isSynced,
};
