import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/timestamp_converters.dart';

part 'plan.freezed.dart';
part 'plan.g.dart';

/// Subscription plan definition.
///
/// Kept small and stable; frequently used fields are duplicated on [Member]
/// and [Payment] documents to avoid extra reads.
@freezed
abstract class Plan with _$Plan {
  const factory Plan({
    /// Firestore document id (client-generated or stable key).
    required String id,
    required String title,
    required int durationDays,
    required double price,
    @Default(true) bool isActive,

    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @NullableTimestampConverter() DateTime? lastSyncedAt,
    @Default(false) bool isSynced,
  }) = _Plan;

  const Plan._();

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}

extension PlanFirestoreX on Plan {
  static Plan fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing plan data for id ${doc.id}');
    }
    return Plan.fromJson(<String, dynamic>{...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }
}