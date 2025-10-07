import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/cart/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(const CartState()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<DeleteFromCart>(_onDeleteFromCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    print('Handling LoadCart event');
    emit(state.copyWith(status: CartStatus.loading, errorMessage: null));
    final result = await repository.getCartItem();
    result.fold(
      onError: (err) {
        print('LoadCart error: $err');
        emit(state.copyWith(
          status: CartStatus.failure,
          errorMessage: 'Failed to load cart: $err',
        ));
      },
      onSuccess: (cart) {
        print('LoadCart success: $cart');
        emit(state.copyWith(
          status: CartStatus.success,
          cart: cart,
          errorMessage: null,
        ));
      },
    );
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    if (state.cart == null) return;

    final updatedItems = state.cart!.items.map((item) {
      if (item.id == event.itemId) {
        final newQty = event.quantity < 1 ? 1 : event.quantity;
        final unitPrice = item.price ~/ item.quantity; // integer division
        return item.copyWith(
          quantity: newQty,
          price: unitPrice * newQty,
        );
      }
      return item;
    }).toList();

    // recalc subtotal & total
    final newSubTotal = updatedItems.fold(0, (sum, item) => sum + item.price);
    final newTotal = newSubTotal + state.cart!.shippingFee + state.cart!.vat;

    final updatedCart = state.cart!.copyWith(
      items: updatedItems,
      subTotal: newSubTotal,
      total: newTotal,
    );

    emit(state.copyWith(cart: updatedCart));
  }


  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    print('Handling AddToCart event: productId=${event.productId}, sizeId=${event.sizeId}');
    emit(state.copyWith(status: CartStatus.loading, errorMessage: null));

    final addResult = await repository.addCartItem(event.productId, event.sizeId);
    if (!addResult.isSuccess) {
      print('AddToCart error: ${addResult.error}');
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to add item to cart: ${addResult.error}',
      ));
      return;
    }
    final cartResult = await repository.getCartItem();
    cartResult.fold(
      onError: (err) {
        print('AddToCart getCartItem error: $err');
        emit(state.copyWith(
          status: CartStatus.failure,
          errorMessage: 'Failed to refresh cart: $err',
        ));
      },
      onSuccess: (cart) {
        print('AddToCart success: $cart');
        emit(state.copyWith(
          status: CartStatus.success,
          cart: cart,
          errorMessage: null,
        ));
      },
    );
  }
  Future<void> _onDeleteFromCart(DeleteFromCart event, Emitter<CartState> emit) async {
    print('Handling DeleteFromCart event: id=${event.id}');
    emit(state.copyWith(status: CartStatus.loading, errorMessage: null));
    final delResult = await repository.deleteCartItem(event.id);
    if (!delResult.isSuccess) {
      print('DeleteFromCart error: ${delResult.error}');
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to delete item: ${delResult.error}',
      ));
      return;
    }

    final cartResult = await repository.getCartItem();
    cartResult.fold(
      onError: (err) {
        print('DeleteFromCart getCartItem error: $err');
        emit(state.copyWith(
          status: CartStatus.failure,
          errorMessage: 'Failed to refresh cart: $err',
        ));
      },
      onSuccess: (cart) {
        print('DeleteFromCart success: $cart');
        emit(state.copyWith(
          status: CartStatus.success,
          cart: cart,
          errorMessage: null,
        ));
      },
    );
  }
}