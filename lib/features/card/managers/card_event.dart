import 'package:equatable/equatable.dart';
import '../../../data/models/payment/payment_model.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class LoadCardsEvent extends PaymentEvent {}

class AddCardEvent extends PaymentEvent {
  final CardModel card;

  const AddCardEvent(this.card);

  @override
  List<Object?> get props => [card];
}

class DeleteCardEvent extends PaymentEvent {
  final int id;

  const DeleteCardEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SelectCardEvent extends PaymentEvent {
  final int selectedId;
  SelectCardEvent(this.selectedId);
}