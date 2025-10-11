// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentState {

 List<CardModel> get cards; int? get selectedCardId;
/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentStateCopyWith<PaymentState> get copyWith => _$PaymentStateCopyWithImpl<PaymentState>(this as PaymentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentState&&const DeepCollectionEquality().equals(other.cards, cards)&&(identical(other.selectedCardId, selectedCardId) || other.selectedCardId == selectedCardId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cards),selectedCardId);

@override
String toString() {
  return 'PaymentState(cards: $cards, selectedCardId: $selectedCardId)';
}


}

/// @nodoc
abstract mixin class $PaymentStateCopyWith<$Res>  {
  factory $PaymentStateCopyWith(PaymentState value, $Res Function(PaymentState) _then) = _$PaymentStateCopyWithImpl;
@useResult
$Res call({
 List<CardModel> cards, int? selectedCardId
});




}
/// @nodoc
class _$PaymentStateCopyWithImpl<$Res>
    implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._self, this._then);

  final PaymentState _self;
  final $Res Function(PaymentState) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cards = null,Object? selectedCardId = freezed,}) {
  return _then(_self.copyWith(
cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardModel>,selectedCardId: freezed == selectedCardId ? _self.selectedCardId : selectedCardId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentState].
extension PaymentStatePatterns on PaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaymentInitial value)?  initial,TResult Function( PaymentLoading value)?  loading,TResult Function( PaymentLoaded value)?  loaded,TResult Function( PaymentError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaymentInitial() when initial != null:
return initial(_that);case PaymentLoading() when loading != null:
return loading(_that);case PaymentLoaded() when loaded != null:
return loaded(_that);case PaymentError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaymentInitial value)  initial,required TResult Function( PaymentLoading value)  loading,required TResult Function( PaymentLoaded value)  loaded,required TResult Function( PaymentError value)  error,}){
final _that = this;
switch (_that) {
case PaymentInitial():
return initial(_that);case PaymentLoading():
return loading(_that);case PaymentLoaded():
return loaded(_that);case PaymentError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaymentInitial value)?  initial,TResult? Function( PaymentLoading value)?  loading,TResult? Function( PaymentLoaded value)?  loaded,TResult? Function( PaymentError value)?  error,}){
final _that = this;
switch (_that) {
case PaymentInitial() when initial != null:
return initial(_that);case PaymentLoading() when loading != null:
return loading(_that);case PaymentLoaded() when loaded != null:
return loaded(_that);case PaymentError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<CardModel> cards,  int? selectedCardId)?  initial,TResult Function( List<CardModel> cards,  int? selectedCardId)?  loading,TResult Function( List<CardModel> cards,  int? selectedCardId)?  loaded,TResult Function( String errorMessage,  List<CardModel> cards,  int? selectedCardId)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaymentInitial() when initial != null:
return initial(_that.cards,_that.selectedCardId);case PaymentLoading() when loading != null:
return loading(_that.cards,_that.selectedCardId);case PaymentLoaded() when loaded != null:
return loaded(_that.cards,_that.selectedCardId);case PaymentError() when error != null:
return error(_that.errorMessage,_that.cards,_that.selectedCardId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<CardModel> cards,  int? selectedCardId)  initial,required TResult Function( List<CardModel> cards,  int? selectedCardId)  loading,required TResult Function( List<CardModel> cards,  int? selectedCardId)  loaded,required TResult Function( String errorMessage,  List<CardModel> cards,  int? selectedCardId)  error,}) {final _that = this;
switch (_that) {
case PaymentInitial():
return initial(_that.cards,_that.selectedCardId);case PaymentLoading():
return loading(_that.cards,_that.selectedCardId);case PaymentLoaded():
return loaded(_that.cards,_that.selectedCardId);case PaymentError():
return error(_that.errorMessage,_that.cards,_that.selectedCardId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<CardModel> cards,  int? selectedCardId)?  initial,TResult? Function( List<CardModel> cards,  int? selectedCardId)?  loading,TResult? Function( List<CardModel> cards,  int? selectedCardId)?  loaded,TResult? Function( String errorMessage,  List<CardModel> cards,  int? selectedCardId)?  error,}) {final _that = this;
switch (_that) {
case PaymentInitial() when initial != null:
return initial(_that.cards,_that.selectedCardId);case PaymentLoading() when loading != null:
return loading(_that.cards,_that.selectedCardId);case PaymentLoaded() when loaded != null:
return loaded(_that.cards,_that.selectedCardId);case PaymentError() when error != null:
return error(_that.errorMessage,_that.cards,_that.selectedCardId);case _:
  return null;

}
}

}

/// @nodoc


class PaymentInitial extends PaymentState {
  const PaymentInitial({final  List<CardModel> cards = const [], this.selectedCardId}): _cards = cards,super._();
  

 final  List<CardModel> _cards;
@override@JsonKey() List<CardModel> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override final  int? selectedCardId;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentInitialCopyWith<PaymentInitial> get copyWith => _$PaymentInitialCopyWithImpl<PaymentInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentInitial&&const DeepCollectionEquality().equals(other._cards, _cards)&&(identical(other.selectedCardId, selectedCardId) || other.selectedCardId == selectedCardId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards),selectedCardId);

@override
String toString() {
  return 'PaymentState.initial(cards: $cards, selectedCardId: $selectedCardId)';
}


}

/// @nodoc
abstract mixin class $PaymentInitialCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory $PaymentInitialCopyWith(PaymentInitial value, $Res Function(PaymentInitial) _then) = _$PaymentInitialCopyWithImpl;
@override @useResult
$Res call({
 List<CardModel> cards, int? selectedCardId
});




}
/// @nodoc
class _$PaymentInitialCopyWithImpl<$Res>
    implements $PaymentInitialCopyWith<$Res> {
  _$PaymentInitialCopyWithImpl(this._self, this._then);

  final PaymentInitial _self;
  final $Res Function(PaymentInitial) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cards = null,Object? selectedCardId = freezed,}) {
  return _then(PaymentInitial(
cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardModel>,selectedCardId: freezed == selectedCardId ? _self.selectedCardId : selectedCardId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class PaymentLoading extends PaymentState {
  const PaymentLoading({final  List<CardModel> cards = const [], this.selectedCardId}): _cards = cards,super._();
  

 final  List<CardModel> _cards;
@override@JsonKey() List<CardModel> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override final  int? selectedCardId;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentLoadingCopyWith<PaymentLoading> get copyWith => _$PaymentLoadingCopyWithImpl<PaymentLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentLoading&&const DeepCollectionEquality().equals(other._cards, _cards)&&(identical(other.selectedCardId, selectedCardId) || other.selectedCardId == selectedCardId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards),selectedCardId);

@override
String toString() {
  return 'PaymentState.loading(cards: $cards, selectedCardId: $selectedCardId)';
}


}

/// @nodoc
abstract mixin class $PaymentLoadingCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory $PaymentLoadingCopyWith(PaymentLoading value, $Res Function(PaymentLoading) _then) = _$PaymentLoadingCopyWithImpl;
@override @useResult
$Res call({
 List<CardModel> cards, int? selectedCardId
});




}
/// @nodoc
class _$PaymentLoadingCopyWithImpl<$Res>
    implements $PaymentLoadingCopyWith<$Res> {
  _$PaymentLoadingCopyWithImpl(this._self, this._then);

  final PaymentLoading _self;
  final $Res Function(PaymentLoading) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cards = null,Object? selectedCardId = freezed,}) {
  return _then(PaymentLoading(
cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardModel>,selectedCardId: freezed == selectedCardId ? _self.selectedCardId : selectedCardId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class PaymentLoaded extends PaymentState {
  const PaymentLoaded({required final  List<CardModel> cards, this.selectedCardId}): _cards = cards,super._();
  

 final  List<CardModel> _cards;
@override List<CardModel> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override final  int? selectedCardId;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentLoadedCopyWith<PaymentLoaded> get copyWith => _$PaymentLoadedCopyWithImpl<PaymentLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentLoaded&&const DeepCollectionEquality().equals(other._cards, _cards)&&(identical(other.selectedCardId, selectedCardId) || other.selectedCardId == selectedCardId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards),selectedCardId);

@override
String toString() {
  return 'PaymentState.loaded(cards: $cards, selectedCardId: $selectedCardId)';
}


}

/// @nodoc
abstract mixin class $PaymentLoadedCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory $PaymentLoadedCopyWith(PaymentLoaded value, $Res Function(PaymentLoaded) _then) = _$PaymentLoadedCopyWithImpl;
@override @useResult
$Res call({
 List<CardModel> cards, int? selectedCardId
});




}
/// @nodoc
class _$PaymentLoadedCopyWithImpl<$Res>
    implements $PaymentLoadedCopyWith<$Res> {
  _$PaymentLoadedCopyWithImpl(this._self, this._then);

  final PaymentLoaded _self;
  final $Res Function(PaymentLoaded) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cards = null,Object? selectedCardId = freezed,}) {
  return _then(PaymentLoaded(
cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardModel>,selectedCardId: freezed == selectedCardId ? _self.selectedCardId : selectedCardId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class PaymentError extends PaymentState {
  const PaymentError({required this.errorMessage, final  List<CardModel> cards = const [], this.selectedCardId}): _cards = cards,super._();
  

 final  String errorMessage;
 final  List<CardModel> _cards;
@override@JsonKey() List<CardModel> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override final  int? selectedCardId;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentErrorCopyWith<PaymentError> get copyWith => _$PaymentErrorCopyWithImpl<PaymentError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentError&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._cards, _cards)&&(identical(other.selectedCardId, selectedCardId) || other.selectedCardId == selectedCardId));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage,const DeepCollectionEquality().hash(_cards),selectedCardId);

@override
String toString() {
  return 'PaymentState.error(errorMessage: $errorMessage, cards: $cards, selectedCardId: $selectedCardId)';
}


}

/// @nodoc
abstract mixin class $PaymentErrorCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory $PaymentErrorCopyWith(PaymentError value, $Res Function(PaymentError) _then) = _$PaymentErrorCopyWithImpl;
@override @useResult
$Res call({
 String errorMessage, List<CardModel> cards, int? selectedCardId
});




}
/// @nodoc
class _$PaymentErrorCopyWithImpl<$Res>
    implements $PaymentErrorCopyWith<$Res> {
  _$PaymentErrorCopyWithImpl(this._self, this._then);

  final PaymentError _self;
  final $Res Function(PaymentError) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,Object? cards = null,Object? selectedCardId = freezed,}) {
  return _then(PaymentError(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardModel>,selectedCardId: freezed == selectedCardId ? _self.selectedCardId : selectedCardId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
