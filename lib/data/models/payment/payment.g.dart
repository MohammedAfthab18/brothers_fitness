// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: json['id'] as String,
  memberId: json['memberId'] as String,
  memberName: json['memberName'] as String,
  planId: json['planId'] as String,
  planName: json['planName'] as String,
  amount: (json['amount'] as num).toDouble(),
  paymentMethod: json['paymentMethod'] as String,
  paidAt: const TimestampConverter().fromJson(json['paidAt']),
  expiryDate: const TimestampConverter().fromJson(json['expiryDate']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  lastSyncedAt: const NullableTimestampConverter().fromJson(
    json['lastSyncedAt'],
  ),
  isSynced: json['isSynced'] as bool? ?? false,
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'memberId': instance.memberId,
  'memberName': instance.memberName,
  'planId': instance.planId,
  'planName': instance.planName,
  'amount': instance.amount,
  'paymentMethod': instance.paymentMethod,
  'paidAt': const TimestampConverter().toJson(instance.paidAt),
  'expiryDate': const TimestampConverter().toJson(instance.expiryDate),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'lastSyncedAt': const NullableTimestampConverter().toJson(
    instance.lastSyncedAt,
  ),
  'isSynced': instance.isSynced,
};
