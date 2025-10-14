import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/orders/order_model.dart';
import '../../../data/repositories/orders/order_repository.dart';
import 'order_events.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc({required this.repository}) : super(OrderInitial()) {
    on<LoadOrders>(_onLoadOrders);
    on<CreateOrder>(_onCreateOrder);
  }

  Future<void> _onLoadOrders(LoadOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await repository.getOrders();
    result.fold(
      onError: (e) => emit(OrderError(e.toString())),
      onSuccess: (orders) {
        if (orders.isEmpty) {
          emit(OrderEmpty());
        } else {
          emit(OrderLoaded(orders));
        }
      },
    );
  }

  Future<void> _onCreateOrder(CreateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await repository.createOrder(
      addressId: event.addressId,
      paymentMethod: event.paymentMethod,
      cardId: event.cardId,
    );
    result.fold(
      onError: (e) => emit(OrderError(e.toString())),
      onSuccess: (_) {
        emit(OrderSuccess());
        add(LoadOrders()); // reload orders after success
      },
    );
  }
}
