import 'package:equatable/equatable.dart';
import '../../../data/models/cart/cart_item_model.dart';

enum CartStatus {
  initial,
  loading,
  success,
  failure,
  orderSuccess,
  orderFailure,
}

class CartState extends Equatable {
  final CartStatus status;
  final CartResponse? cart;
  final String? errorMessage;

  const CartState({
    this.status = CartStatus.initial,
    this.cart,
    this.errorMessage,
  });

  CartState copyWith({
    CartStatus? status,
    CartResponse? cart,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, cart, errorMessage];
}
