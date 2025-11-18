import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/timestamp_converters.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

/// Payment record for a member's subscription.
///
/// Denormalized fields (memberName, planName, expiryDate) allow building
/// statements and reports with a single collection read.
@freezed
class Payment with _$Payment {
  @JsonSerializable(explicitToJson: true)
  const factory Payment({
    /// Firestore document id (client-generated).
    required String id,

    /// Member reference.
    required String memberId,

    /// Denormalized member name for quick display.
    required String memberName,

    /// Plan reference.
    required String planId,

    /// Denormalized plan title.
    required String planName,

    /// Paid amount.
    required double amount,

    /// Payment method (cash, card, transfer, etc.).
    required String paymentMethod,

    /// When the payment was made.
    @TimestampConverter() required DateTime paidAt,

    /// When the purchased period expires.
    @TimestampConverter() required DateTime expiryDate,

    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @NullableTimestampConverter() DateTime? lastSyncedAt,
    @Default(false) bool isSynced,
  }) = _Payment;

  const Payment._();

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}

extension PaymentFirestoreX on Payment {
  static Payment fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing payment data for id ${doc.id}');
    }
    return Payment.fromJson(<String, dynamic>{...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }
}


