import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/timestamp_converters.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

/// Reminder to notify members about upcoming expiries or other events.
///
/// Denormalized fields allow sending messages without additional reads:
/// memberName, whatsappNumber, planName, expiryDate.
@freezed
abstract class Reminder with _$Reminder {
  const factory Reminder({
    /// Firestore document id (client-generated).
    required String id,

    /// Member reference.
    required String memberId,

    /// Denormalized member name.
    required String memberName,

    /// Denormalized WhatsApp number to send the reminder to.
    required String whatsappNumber,

    /// Denormalized plan title.
    required String planName,

    /// Plan expiry date for which this reminder is scheduled.
    @TimestampConverter() required DateTime expiryDate,

    /// Type of reminder: 1_day_before | 3_days_before | 7_days_before.
    required String reminderType,

    /// Channel used to send the reminder (e.g. whatsapp, sms).
    required String channel,

    /// Whether the reminder has already been sent.
    @Default(false) bool isSent,

    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @NullableTimestampConverter() DateTime? lastSyncedAt,
    @Default(false) bool isSynced,
  }) = _Reminder;

  const Reminder._();

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
}

extension ReminderFirestoreX on Reminder {
  static Reminder fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing reminder data for id ${doc.id}');
    }
    return Reminder.fromJson(<String, dynamic>{...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }
}