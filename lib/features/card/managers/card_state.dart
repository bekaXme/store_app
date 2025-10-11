import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/payment/payment_model.dart';

part 'card_state.freezed.dart';

@freezed
abstract class PaymentState with _$PaymentState {
  const PaymentState._();

  const factory PaymentState.initial({
    @Default([]) List<CardModel> cards,
    int? selectedCardId,
  }) = PaymentInitial;

  const factory PaymentState.loading({
    @Default([]) List<CardModel> cards,
    int? selectedCardId,
  }) = PaymentLoading;

  const factory PaymentState.loaded({
    required List<CardModel> cards,
    int? selectedCardId,
  }) = PaymentLoaded;

  const factory PaymentState.error({
    required String errorMessage,
    @Default([]) List<CardModel> cards,
    int? selectedCardId,
  }) = PaymentError;
}
