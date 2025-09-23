import 'package:equatable/equatable.dart';

import '../../../data/models/home/saved_product_model.dart';

enum SavedProductsStatus { initial, loading, success, failure }

class SavedProductsState extends Equatable {
  final SavedProductsStatus status;
  final List<SavedProductsModel> savedProducts;
  final String? errorMessage;

  const SavedProductsState({
    required this.status,
    required this.savedProducts,
    this.errorMessage,
  });

  factory SavedProductsState.initial() => const SavedProductsState(
    status: SavedProductsStatus.initial,
    savedProducts: [],
  );

  SavedProductsState copyWith({
    SavedProductsStatus? status,
    List<SavedProductsModel>? savedProducts,
    String? errorMessage,
  }) {
    return SavedProductsState(
      status: status ?? this.status,
      savedProducts: savedProducts ?? this.savedProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, savedProducts, errorMessage];
}
