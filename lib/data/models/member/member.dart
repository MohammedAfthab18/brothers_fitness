import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/timestamp_converters.dart';

part 'member.freezed.dart';
part 'member.g.dart';

/// Member aggregate document.
///
/// Denormalized to minimize Firestore reads:
/// - Includes current plan summary (planName, planPrice, planDurationDays).
/// - Includes latest payment summary (lastPaidAmount, lastPaidDate, expiryDate).
/// - Includes cached attendanceCount for dashboards.
/// - Includes optional inline notes blocks (kept small and capped in UI).
@freezed
abstract class Member with _$Member {
  const factory Member({
    /// Firestore document id (client-generated).
    required String id,

    /// Full name for display and search.
    required String fullName,

    /// Primary phone number.
    required String phone,

    /// WhatsApp number used for messaging (may equal [phone]).
    required String whatsappNumber,

    /// Member status: active | expired | paused.
    required String status,

    /// Current plan id (foreign key).
    required String planId,

    /// Denormalized plan title.
    required String planName,

    /// Denormalized plan price.
    required double planPrice,

    /// Denormalized plan duration (days).
    required int planDurationDays,

    /// Latest payment amount.
    required double lastPaidAmount,

    /// Latest payment date.
    @TimestampConverter() required DateTime lastPaidDate,

    /// Current plan expiry date.
    @TimestampConverter() required DateTime expiryDate,

    /// Cached attendance count (total check-ins).
    @Default(0) int attendanceCount,

    /// Optional base64-encoded profile image (compressed).
    String? photoBase64,

    /// Lightweight Notion-style notes.
    @Default(<MemberNoteBlock>[]) List<MemberNoteBlock> notes,

    /// Record creation time.
    @TimestampConverter() required DateTime createdAt,

    /// Last local mutation time.
    @TimestampConverter() required DateTime updatedAt,

    /// Last time this document was successfully synced with Firestore.
    @NullableTimestampConverter() DateTime? lastSyncedAt,

    /// Whether the latest local state is in sync with Firestore.
    @Default(false) bool isSynced,
  }) = _Member;

  const Member._();

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}

/// Individual note block embedded in [Member].
@freezed
abstract class MemberNoteBlock with _$MemberNoteBlock {
  const factory MemberNoteBlock({
    required String id,
    required String type, // text | checklist | tag | heading
    required String content,
    @TimestampConverter() required DateTime createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _MemberNoteBlock;

  factory MemberNoteBlock.fromJson(Map<String, dynamic> json) =>
      _$MemberNoteBlockFromJson(json);
}

extension MemberFirestoreX on Member {
  /// Converts a Firestore [DocumentSnapshot] into a [Member].
  static Member fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing member data for id ${doc.id}');
    }
    return Member.fromJson(<String, dynamic>{...data, 'id': doc.id});
  }

  /// Converts this [Member] into a Firestore-compatible map.
  ///
  /// The [id] is excluded because it is encoded in the document path.
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }
}
