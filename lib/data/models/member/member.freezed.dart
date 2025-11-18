// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Member {

/// Firestore document id (client-generated).
 String get id;/// Full name for display and search.
 String get fullName;/// Primary phone number.
 String get phone;/// WhatsApp number used for messaging (may equal [phone]).
 String get whatsappNumber;/// Member status: active | expired | paused.
 String get status;/// Current plan id (foreign key).
 String get planId;/// Denormalized plan title.
 String get planName;/// Denormalized plan price.
 double get planPrice;/// Denormalized plan duration (days).
 int get planDurationDays;/// Latest payment amount.
 double get lastPaidAmount;/// Latest payment date.
@TimestampConverter() DateTime get lastPaidDate;/// Current plan expiry date.
@TimestampConverter() DateTime get expiryDate;/// Cached attendance count (total check-ins).
 int get attendanceCount;/// Optional base64-encoded profile image (compressed).
 String? get photoBase64;/// Lightweight Notion-style notes.
 List<MemberNoteBlock> get notes;/// Record creation time.
@TimestampConverter() DateTime get createdAt;/// Last local mutation time.
@TimestampConverter() DateTime get updatedAt;/// Last time this document was successfully synced with Firestore.
@NullableTimestampConverter() DateTime? get lastSyncedAt;/// Whether the latest local state is in sync with Firestore.
 bool get isSynced;
/// Create a copy of Member
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberCopyWith<Member> get copyWith => _$MemberCopyWithImpl<Member>(this as Member, _$identity);

  /// Serializes this Member to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Member&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsappNumber, whatsappNumber) || other.whatsappNumber == whatsappNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.planPrice, planPrice) || other.planPrice == planPrice)&&(identical(other.planDurationDays, planDurationDays) || other.planDurationDays == planDurationDays)&&(identical(other.lastPaidAmount, lastPaidAmount) || other.lastPaidAmount == lastPaidAmount)&&(identical(other.lastPaidDate, lastPaidDate) || other.lastPaidDate == lastPaidDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.attendanceCount, attendanceCount) || other.attendanceCount == attendanceCount)&&(identical(other.photoBase64, photoBase64) || other.photoBase64 == photoBase64)&&const DeepCollectionEquality().equals(other.notes, notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,phone,whatsappNumber,status,planId,planName,planPrice,planDurationDays,lastPaidAmount,lastPaidDate,expiryDate,attendanceCount,photoBase64,const DeepCollectionEquality().hash(notes),createdAt,updatedAt,lastSyncedAt,isSynced]);

@override
String toString() {
  return 'Member(id: $id, fullName: $fullName, phone: $phone, whatsappNumber: $whatsappNumber, status: $status, planId: $planId, planName: $planName, planPrice: $planPrice, planDurationDays: $planDurationDays, lastPaidAmount: $lastPaidAmount, lastPaidDate: $lastPaidDate, expiryDate: $expiryDate, attendanceCount: $attendanceCount, photoBase64: $photoBase64, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, lastSyncedAt: $lastSyncedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class $MemberCopyWith<$Res>  {
  factory $MemberCopyWith(Member value, $Res Function(Member) _then) = _$MemberCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String phone, String whatsappNumber, String status, String planId, String planName, double planPrice, int planDurationDays, double lastPaidAmount,@TimestampConverter() DateTime lastPaidDate,@TimestampConverter() DateTime expiryDate, int attendanceCount, String? photoBase64, List<MemberNoteBlock> notes,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt,@NullableTimestampConverter() DateTime? lastSyncedAt, bool isSynced
});




}
/// @nodoc
class _$MemberCopyWithImpl<$Res>
    implements $MemberCopyWith<$Res> {
  _$MemberCopyWithImpl(this._self, this._then);

  final Member _self;
  final $Res Function(Member) _then;

/// Create a copy of Member
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? phone = null,Object? whatsappNumber = null,Object? status = null,Object? planId = null,Object? planName = null,Object? planPrice = null,Object? planDurationDays = null,Object? lastPaidAmount = null,Object? lastPaidDate = null,Object? expiryDate = null,Object? attendanceCount = null,Object? photoBase64 = freezed,Object? notes = null,Object? createdAt = null,Object? updatedAt = null,Object? lastSyncedAt = freezed,Object? isSynced = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,whatsappNumber: null == whatsappNumber ? _self.whatsappNumber : whatsappNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,planPrice: null == planPrice ? _self.planPrice : planPrice // ignore: cast_nullable_to_non_nullable
as double,planDurationDays: null == planDurationDays ? _self.planDurationDays : planDurationDays // ignore: cast_nullable_to_non_nullable
as int,lastPaidAmount: null == lastPaidAmount ? _self.lastPaidAmount : lastPaidAmount // ignore: cast_nullable_to_non_nullable
as double,lastPaidDate: null == lastPaidDate ? _self.lastPaidDate : lastPaidDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,attendanceCount: null == attendanceCount ? _self.attendanceCount : attendanceCount // ignore: cast_nullable_to_non_nullable
as int,photoBase64: freezed == photoBase64 ? _self.photoBase64 : photoBase64 // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<MemberNoteBlock>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Member].
extension MemberPatterns on Member {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Member value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Member() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Member value)  $default,){
final _that = this;
switch (_that) {
case _Member():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Member value)?  $default,){
final _that = this;
switch (_that) {
case _Member() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String phone,  String whatsappNumber,  String status,  String planId,  String planName,  double planPrice,  int planDurationDays,  double lastPaidAmount, @TimestampConverter()  DateTime lastPaidDate, @TimestampConverter()  DateTime expiryDate,  int attendanceCount,  String? photoBase64,  List<MemberNoteBlock> notes, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt, @NullableTimestampConverter()  DateTime? lastSyncedAt,  bool isSynced)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Member() when $default != null:
return $default(_that.id,_that.fullName,_that.phone,_that.whatsappNumber,_that.status,_that.planId,_that.planName,_that.planPrice,_that.planDurationDays,_that.lastPaidAmount,_that.lastPaidDate,_that.expiryDate,_that.attendanceCount,_that.photoBase64,_that.notes,_that.createdAt,_that.updatedAt,_that.lastSyncedAt,_that.isSynced);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String phone,  String whatsappNumber,  String status,  String planId,  String planName,  double planPrice,  int planDurationDays,  double lastPaidAmount, @TimestampConverter()  DateTime lastPaidDate, @TimestampConverter()  DateTime expiryDate,  int attendanceCount,  String? photoBase64,  List<MemberNoteBlock> notes, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt, @NullableTimestampConverter()  DateTime? lastSyncedAt,  bool isSynced)  $default,) {final _that = this;
switch (_that) {
case _Member():
return $default(_that.id,_that.fullName,_that.phone,_that.whatsappNumber,_that.status,_that.planId,_that.planName,_that.planPrice,_that.planDurationDays,_that.lastPaidAmount,_that.lastPaidDate,_that.expiryDate,_that.attendanceCount,_that.photoBase64,_that.notes,_that.createdAt,_that.updatedAt,_that.lastSyncedAt,_that.isSynced);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String phone,  String whatsappNumber,  String status,  String planId,  String planName,  double planPrice,  int planDurationDays,  double lastPaidAmount, @TimestampConverter()  DateTime lastPaidDate, @TimestampConverter()  DateTime expiryDate,  int attendanceCount,  String? photoBase64,  List<MemberNoteBlock> notes, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt, @NullableTimestampConverter()  DateTime? lastSyncedAt,  bool isSynced)?  $default,) {final _that = this;
switch (_that) {
case _Member() when $default != null:
return $default(_that.id,_that.fullName,_that.phone,_that.whatsappNumber,_that.status,_that.planId,_that.planName,_that.planPrice,_that.planDurationDays,_that.lastPaidAmount,_that.lastPaidDate,_that.expiryDate,_that.attendanceCount,_that.photoBase64,_that.notes,_that.createdAt,_that.updatedAt,_that.lastSyncedAt,_that.isSynced);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Member extends Member {
  const _Member({required this.id, required this.fullName, required this.phone, required this.whatsappNumber, required this.status, required this.planId, required this.planName, required this.planPrice, required this.planDurationDays, required this.lastPaidAmount, @TimestampConverter() required this.lastPaidDate, @TimestampConverter() required this.expiryDate, this.attendanceCount = 0, this.photoBase64, final  List<MemberNoteBlock> notes = const <MemberNoteBlock>[], @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, @NullableTimestampConverter() this.lastSyncedAt, this.isSynced = false}): _notes = notes,super._();
  factory _Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

/// Firestore document id (client-generated).
@override final  String id;
/// Full name for display and search.
@override final  String fullName;
/// Primary phone number.
@override final  String phone;
/// WhatsApp number used for messaging (may equal [phone]).
@override final  String whatsappNumber;
/// Member status: active | expired | paused.
@override final  String status;
/// Current plan id (foreign key).
@override final  String planId;
/// Denormalized plan title.
@override final  String planName;
/// Denormalized plan price.
@override final  double planPrice;
/// Denormalized plan duration (days).
@override final  int planDurationDays;
/// Latest payment amount.
@override final  double lastPaidAmount;
/// Latest payment date.
@override@TimestampConverter() final  DateTime lastPaidDate;
/// Current plan expiry date.
@override@TimestampConverter() final  DateTime expiryDate;
/// Cached attendance count (total check-ins).
@override@JsonKey() final  int attendanceCount;
/// Optional base64-encoded profile image (compressed).
@override final  String? photoBase64;
/// Lightweight Notion-style notes.
 final  List<MemberNoteBlock> _notes;
/// Lightweight Notion-style notes.
@override@JsonKey() List<MemberNoteBlock> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

/// Record creation time.
@override@TimestampConverter() final  DateTime createdAt;
/// Last local mutation time.
@override@TimestampConverter() final  DateTime updatedAt;
/// Last time this document was successfully synced with Firestore.
@override@NullableTimestampConverter() final  DateTime? lastSyncedAt;
/// Whether the latest local state is in sync with Firestore.
@override@JsonKey() final  bool isSynced;

/// Create a copy of Member
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberCopyWith<_Member> get copyWith => __$MemberCopyWithImpl<_Member>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Member&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsappNumber, whatsappNumber) || other.whatsappNumber == whatsappNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.planPrice, planPrice) || other.planPrice == planPrice)&&(identical(other.planDurationDays, planDurationDays) || other.planDurationDays == planDurationDays)&&(identical(other.lastPaidAmount, lastPaidAmount) || other.lastPaidAmount == lastPaidAmount)&&(identical(other.lastPaidDate, lastPaidDate) || other.lastPaidDate == lastPaidDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.attendanceCount, attendanceCount) || other.attendanceCount == attendanceCount)&&(identical(other.photoBase64, photoBase64) || other.photoBase64 == photoBase64)&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,phone,whatsappNumber,status,planId,planName,planPrice,planDurationDays,lastPaidAmount,lastPaidDate,expiryDate,attendanceCount,photoBase64,const DeepCollectionEquality().hash(_notes),createdAt,updatedAt,lastSyncedAt,isSynced]);

@override
String toString() {
  return 'Member(id: $id, fullName: $fullName, phone: $phone, whatsappNumber: $whatsappNumber, status: $status, planId: $planId, planName: $planName, planPrice: $planPrice, planDurationDays: $planDurationDays, lastPaidAmount: $lastPaidAmount, lastPaidDate: $lastPaidDate, expiryDate: $expiryDate, attendanceCount: $attendanceCount, photoBase64: $photoBase64, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, lastSyncedAt: $lastSyncedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class _$MemberCopyWith<$Res> implements $MemberCopyWith<$Res> {
  factory _$MemberCopyWith(_Member value, $Res Function(_Member) _then) = __$MemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String phone, String whatsappNumber, String status, String planId, String planName, double planPrice, int planDurationDays, double lastPaidAmount,@TimestampConverter() DateTime lastPaidDate,@TimestampConverter() DateTime expiryDate, int attendanceCount, String? photoBase64, List<MemberNoteBlock> notes,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt,@NullableTimestampConverter() DateTime? lastSyncedAt, bool isSynced
});




}
/// @nodoc
class __$MemberCopyWithImpl<$Res>
    implements _$MemberCopyWith<$Res> {
  __$MemberCopyWithImpl(this._self, this._then);

  final _Member _self;
  final $Res Function(_Member) _then;

/// Create a copy of Member
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? phone = null,Object? whatsappNumber = null,Object? status = null,Object? planId = null,Object? planName = null,Object? planPrice = null,Object? planDurationDays = null,Object? lastPaidAmount = null,Object? lastPaidDate = null,Object? expiryDate = null,Object? attendanceCount = null,Object? photoBase64 = freezed,Object? notes = null,Object? createdAt = null,Object? updatedAt = null,Object? lastSyncedAt = freezed,Object? isSynced = null,}) {
  return _then(_Member(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,whatsappNumber: null == whatsappNumber ? _self.whatsappNumber : whatsappNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,planPrice: null == planPrice ? _self.planPrice : planPrice // ignore: cast_nullable_to_non_nullable
as double,planDurationDays: null == planDurationDays ? _self.planDurationDays : planDurationDays // ignore: cast_nullable_to_non_nullable
as int,lastPaidAmount: null == lastPaidAmount ? _self.lastPaidAmount : lastPaidAmount // ignore: cast_nullable_to_non_nullable
as double,lastPaidDate: null == lastPaidDate ? _self.lastPaidDate : lastPaidDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,attendanceCount: null == attendanceCount ? _self.attendanceCount : attendanceCount // ignore: cast_nullable_to_non_nullable
as int,photoBase64: freezed == photoBase64 ? _self.photoBase64 : photoBase64 // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<MemberNoteBlock>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MemberNoteBlock {

 String get id; String get type;// text | checklist | tag | heading
 String get content;@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;
/// Create a copy of MemberNoteBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberNoteBlockCopyWith<MemberNoteBlock> get copyWith => _$MemberNoteBlockCopyWithImpl<MemberNoteBlock>(this as MemberNoteBlock, _$identity);

  /// Serializes this MemberNoteBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberNoteBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,content,createdAt,updatedAt);

@override
String toString() {
  return 'MemberNoteBlock(id: $id, type: $type, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MemberNoteBlockCopyWith<$Res>  {
  factory $MemberNoteBlockCopyWith(MemberNoteBlock value, $Res Function(MemberNoteBlock) _then) = _$MemberNoteBlockCopyWithImpl;
@useResult
$Res call({
 String id, String type, String content,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$MemberNoteBlockCopyWithImpl<$Res>
    implements $MemberNoteBlockCopyWith<$Res> {
  _$MemberNoteBlockCopyWithImpl(this._self, this._then);

  final MemberNoteBlock _self;
  final $Res Function(MemberNoteBlock) _then;

/// Create a copy of MemberNoteBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? content = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberNoteBlock].
extension MemberNoteBlockPatterns on MemberNoteBlock {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberNoteBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberNoteBlock() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberNoteBlock value)  $default,){
final _that = this;
switch (_that) {
case _MemberNoteBlock():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberNoteBlock value)?  $default,){
final _that = this;
switch (_that) {
case _MemberNoteBlock() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String content, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberNoteBlock() when $default != null:
return $default(_that.id,_that.type,_that.content,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String content, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MemberNoteBlock():
return $default(_that.id,_that.type,_that.content,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String content, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MemberNoteBlock() when $default != null:
return $default(_that.id,_that.type,_that.content,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _MemberNoteBlock implements MemberNoteBlock {
  const _MemberNoteBlock({required this.id, required this.type, required this.content, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.updatedAt});
  factory _MemberNoteBlock.fromJson(Map<String, dynamic> json) => _$MemberNoteBlockFromJson(json);

@override final  String id;
@override final  String type;
// text | checklist | tag | heading
@override final  String content;
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of MemberNoteBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberNoteBlockCopyWith<_MemberNoteBlock> get copyWith => __$MemberNoteBlockCopyWithImpl<_MemberNoteBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberNoteBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberNoteBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,content,createdAt,updatedAt);

@override
String toString() {
  return 'MemberNoteBlock(id: $id, type: $type, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MemberNoteBlockCopyWith<$Res> implements $MemberNoteBlockCopyWith<$Res> {
  factory _$MemberNoteBlockCopyWith(_MemberNoteBlock value, $Res Function(_MemberNoteBlock) _then) = __$MemberNoteBlockCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String content,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$MemberNoteBlockCopyWithImpl<$Res>
    implements _$MemberNoteBlockCopyWith<$Res> {
  __$MemberNoteBlockCopyWithImpl(this._self, this._then);

  final _MemberNoteBlock _self;
  final $Res Function(_MemberNoteBlock) _then;

/// Create a copy of MemberNoteBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? content = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_MemberNoteBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
