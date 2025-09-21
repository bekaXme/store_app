import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/home/saved_product_model.dart';
part 'saved_products_state.freezed.dart';

enum Status { idle, loading, success, error }

@freezed
abstract class SavedState with _$SavedState {
  const factory SavedState({
    required Status status,
    required String? errorSavedMessage,
    required List<SavedProductsModel> savedProducts,
  }) = _SavedState;

  factory SavedState.initial()=>SavedState(status: Status.idle, errorSavedMessage: null, savedProducts: []);
}
