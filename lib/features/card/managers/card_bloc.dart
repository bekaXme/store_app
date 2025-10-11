import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/payment/payment_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository repository;

  PaymentBloc({required this.repository}) : super(const PaymentInitial()) {
    on<LoadCardsEvent>(_onLoadCards);
    on<AddCardEvent>(_onAddCard);
    on<DeleteCardEvent>(_onDeleteCard);
    on<SelectCardEvent>(_onSelectCard);
  }

  Future<void> _onLoadCards(
    LoadCardsEvent event,
    Emitter<PaymentState> emit,
  ) async {
    print('Handling LoadCardsEvent');
    emit(const PaymentLoading());
    final result = await repository.getCards();
    result.fold(
      onError: (e) {
        print('LoadCards error: $e');
        emit(PaymentError(errorMessage: 'Error $e'));
      },
      onSuccess: (cards) {
        print('LoadCards success: $cards');
        emit(PaymentLoaded(cards: cards));
      },
    );
  }

  Future<void> _onAddCard(
    AddCardEvent event,
    Emitter<PaymentState> emit,
  ) async {
    print('Handling AddCardEvent: card=${event.card}');
    final currentState = state;
    emit(const PaymentLoading());

    final result = await repository.postCard(event.card);
    result.fold(
      onError: (e) {
        print('AddCard error: $e');
        emit(PaymentError(errorMessage: 'Failed to add card: $e'));
      },
      onSuccess: (newCard) async {
        print('AddCard success: $newCard');
        final cardsResult = await repository.getCards();
        cardsResult.fold(
          onError: (e) {
            print('AddCard getCards error: $e');
            emit(PaymentError(errorMessage: 'Failed to refresh cards: $e'));
          },
          onSuccess: (cards) {
            print('AddCard getCards success: $cards');
            emit(
              PaymentLoaded(
                cards: cards,
                selectedCardId: currentState.selectedCardId,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onDeleteCard(
    DeleteCardEvent event,
    Emitter<PaymentState> emit,
  ) async {
    print('Handling DeleteCardEvent: id=${event.id}');
    final currentState = state;
    emit(const PaymentLoading());
    final result = await repository.deleteCard(event.id);
    result.fold(
      onError: (e) {
        print('DeleteCard error: $e');
        emit(PaymentError(errorMessage: 'Failed to delete card: $e'));
      },
      onSuccess: (_) async {
        print('DeleteCard success');
        final cardsResult = await repository.getCards();
        cardsResult.fold(
          onError: (e) {
            print('DeleteCard getCards error: $e');
            emit(PaymentError(errorMessage: 'Failed to refresh cards: $e'));
          },
          onSuccess: (cards) {
            print('DeleteCard getCards success: $cards');
            emit(
              PaymentLoaded(
                cards: cards,
                selectedCardId: currentState.selectedCardId == event.id
                    ? null
                    : currentState.selectedCardId,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onSelectCard(
    SelectCardEvent event,
    Emitter<PaymentState> emit,
  ) async {
    print('Handling SelectCardEvent: id=${event.selectedId}');
    final currentState = state;
    currentState.maybeWhen(
      orElse: () {
        emit(const PaymentInitial());
      },
    );
  }
}
