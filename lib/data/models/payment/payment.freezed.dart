// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Payment {

/// Firestore document id (client-generated).
 String get id;/// Member reference.
 String get memberId;/// Denormalized member name for quick display.
 String get memberName;/// Plan reference.
 String get planId;/// Denormalized plan title.
 String get planName;/// Paid amount.
 double get amount;/// Payment method (cash, card, transfer, etc.).
 String get paymentMethod;/// When the payment was made.
@TimestampConverter() DateTime get paidAt;/// When the purchased period expires.
@TimestampConverter() DateTime get expiryDate;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;@NullableTimestampConverter() DateTime? get lastSyncedAt; bool get isSynced;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,memberId,memberName,planId,planName,amount,paymentMethod,paidAt,expiryDate,createdAt,updatedAt,lastSyncedAt,isSynced);

@override
String toString() {
  return 'Payment(id: $id, memberId: $memberId, memberName: $memberName, planId: $planId, planName: $planName, amount: $amount, paymentMethod: $paymentMethod, paidAt: $paidAt, expiryDate: $expiryDate, createdAt: $createdAt, updatedAt: $updatedAt, lastSyncedAt: $lastSyncedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String id, String memberId, String memberName, String planId, String planName, double amount, String paymentMethod,@TimestampConverter() DateTime paidAt,@TimestampConverter() DateTime expiryDate,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt,@NullableTimestampConverter() DateTime? lastSyncedAt, bool isSynced
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? memberId = null,Object? memberName = null,Object? planId = null,Object? planName = null,Object? amount = null,Object? paymentMethod = null,Object? paidAt = null,Object? expiryDate = null,Object? createdAt = null,Object? updatedAt = null,Object? lastSyncedAt = freezed,Object? isSynced = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String memberId,  String memberName,  String planId,  String planName,  double amount,  String paymentMethod, @TimestampConverter()  DateTime paidAt, @TimestampConverter()  DateTime expiryDate, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt, @NullableTimestampConverter()  DateTime? lastSyncedAt,  bool isSynced)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.memberId,_that.memberName,_that.planId,_that.planName,_that.amount,_that.paymentMethod,_that.paidAt,_that.expiryDate,_that.createdAt,_that.updatedAt,_that.lastSyncedAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String memberId,  String memberName,  String planId,  String planName,  double amount,  String paymentMethod, @TimestampConverter()  DateTime paidAt, @TimestampConverter()  DateTime expiryDate, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt, @NullableTimestampConverter()  DateTime? lastSyncedAt,  bool isSynced)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.memberId,_that.memberName,_that.planId,_that.planName,_that.amount,_that.paymentMethod,_that.paidAt,_that.expiryDate,_that.createdAt,_that.updatedAt,_that.lastSyncedAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String memberId,  String memberName,  String planId,  String planName,  double amount,  String paymentMethod, @TimestampConverter()  DateTime paidAt, @TimestampConverter()  DateTime expiryDate, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt, @NullableTimestampConverter()  DateTime? lastSyncedAt,  bool isSynced)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.memberId,_that.memberName,_that.planId,_that.planName,_that.amount,_that.paymentMethod,_that.paidAt,_that.expiryDate,_that.createdAt,_that.updatedAt,_that.lastSyncedAt,_that.isSynced);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payment extends Payment {
  const _Payment({required this.id, required this.memberId, required this.memberName, required this.planId, required this.planName, required this.amount, required this.paymentMethod, @TimestampConverter() required this.paidAt, @TimestampConverter() required this.expiryDate, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, @NullableTimestampConverter() this.lastSyncedAt, this.isSynced = false}): super._();
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

/// Firestore document id (client-generated).
@override final  String id;
/// Member reference.
@override final  String memberId;
/// Denormalized member name for quick display.
@override final  String memberName;
/// Plan reference.
@override final  String planId;
/// Denormalized plan title.
@override final  String planName;
/// Paid amount.
@override final  double amount;
/// Payment method (cash, card, transfer, etc.).
@override final  String paymentMethod;
/// When the payment was made.
@override@TimestampConverter() final  DateTime paidAt;
/// When the purchased period expires.
@override@TimestampConverter() final  DateTime expiryDate;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override@NullableTimestampConverter() final  DateTime? lastSyncedAt;
@override@JsonKey() final  bool isSynced;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.memberName, memberName) || other.memberName == memberName)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,memberId,memberName,planId,planName,amount,paymentMethod,paidAt,expiryDate,createdAt,updatedAt,lastSyncedAt,isSynced);

@override
String toString() {
  return 'Payment(id: $id, memberId: $memberId, memberName: $memberName, planId: $planId, planName: $planName, amount: $amount, paymentMethod: $paymentMethod, paidAt: $paidAt, expiryDate: $expiryDate, createdAt: $createdAt, updatedAt: $updatedAt, lastSyncedAt: $lastSyncedAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String memberId, String memberName, String planId, String planName, double amount, String paymentMethod,@TimestampConverter() DateTime paidAt,@TimestampConverter() DateTime expiryDate,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt,@NullableTimestampConverter() DateTime? lastSyncedAt, bool isSynced
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? memberId = null,Object? memberName = null,Object? planId = null,Object? planName = null,Object? amount = null,Object? paymentMethod = null,Object? paidAt = null,Object? expiryDate = null,Object? createdAt = null,Object? updatedAt = null,Object? lastSyncedAt = freezed,Object? isSynced = null,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,memberName: null == memberName ? _self.memberName : memberName // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
