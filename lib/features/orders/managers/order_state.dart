import 'package:equatable/equatable.dart';
import '../../../data/models/orders/order_model.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  OrderLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderEmpty extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);

  @override
  List<Object?> get props => [message];
}
