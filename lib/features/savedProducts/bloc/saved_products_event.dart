import 'package:equatable/equatable.dart';

abstract class SavedProductsEvent extends Equatable {
  const SavedProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSavedProducts extends SavedProductsEvent {}

class ToggleSaveProduct extends SavedProductsEvent {
  final int productId;

  const ToggleSaveProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}
