import 'package:equatable/equatable.dart';
import '../../../data/models/payment/payment_model.dart';

abstract class PaymentState extends Equatable {
  final List<CardModel> cards;
  final int? selectedCardId;
  final bool isLoading;
  final String? errorMessage;

  const PaymentState({
    this.cards = const [],
    this.selectedCardId,
    this.isLoading = false,
    this.errorMessage,
  });

  PaymentState copyWith({
    List<CardModel>? cards,
    int? selectedCardId,
    bool? isLoading,
    String? errorMessage,
  });

  @override
  List<Object?> get props => [cards, selectedCardId, isLoading, errorMessage];
}

// Initial state
class PaymentInitial extends PaymentState {
  const PaymentInitial() : super();

  @override
  PaymentState copyWith({
    List<CardModel>? cards,
    int? selectedCardId,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PaymentInitial();
  }
}

// Loading state
class PaymentLoading extends PaymentState {
  const PaymentLoading({List<CardModel> cards = const [], int? selectedCardId})
      : super(cards: cards, selectedCardId: selectedCardId, isLoading: true);

  @override
  PaymentState copyWith({
    List<CardModel>? cards,
    int? selectedCardId,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PaymentLoading(
      cards: cards ?? this.cards,
      selectedCardId: selectedCardId ?? this.selectedCardId,
    );
  }
}

// Loaded state
class PaymentLoaded extends PaymentState {
  const PaymentLoaded({
    required List<CardModel> cards,
    int? selectedCardId,
  }) : super(cards: cards, selectedCardId: selectedCardId);

  @override
  PaymentState copyWith({
    List<CardModel>? cards,
    int? selectedCardId,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PaymentLoaded(
      cards: cards ?? this.cards,
      selectedCardId: selectedCardId ?? this.selectedCardId,
    );
  }
}

// Error state
class PaymentError extends PaymentState {
  const PaymentError(String message)
      : super(errorMessage: message, isLoading: false);

  @override
  PaymentState copyWith({
    List<CardModel>? cards,
    int? selectedCardId,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PaymentError(errorMessage ?? this.errorMessage!);
  }
}
