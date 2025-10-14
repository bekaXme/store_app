import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadOrders extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final int addressId;
  final String paymentMethod;
  final int? cardId;

   CreateOrder({
    required this.addressId,
    required this.paymentMethod,
    this.cardId,
  });

  @override
  List<Object?> get props => [addressId, paymentMethod, cardId];
}