import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
@override
List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
final int productId;
final int sizeId;

AddToCart({
required this.productId,
this.sizeId = 1,
});

@override
List<Object?> get props => [productId, sizeId];
}

class UpdateQuantity extends CartEvent {
final int itemId;
final int quantity;

UpdateQuantity(this.itemId, this.quantity);

@override
List<Object?> get props => [itemId, quantity];
}

class DeleteFromCart extends CartEvent {
final int id;

DeleteFromCart(this.id);

@override
List<Object?> get props => [id];
}

class ClearCart extends CartEvent {}

class PlaceOrder extends CartEvent {
final int addressId;
final String paymentMethod;
final int? cardId;

PlaceOrder({
required this.addressId,
required this.paymentMethod,
this.cardId,
});

@override
List<Object?> get props => [addressId, paymentMethod, cardId];
}