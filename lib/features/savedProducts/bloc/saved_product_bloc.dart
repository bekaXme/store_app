import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/home/saved_product_model.dart';
import '../../../data/repositories/savedProducts/saved_products_repository.dart';
import 'saved_products_event.dart';
import 'saved_products_state.dart';

class SavedProductsBloc extends Bloc<SavedProductsEvent, SavedProductsState> {
  final SavedProductsRepository repository;

  SavedProductsBloc({required this.repository}) : super(SavedProductsState.initial()) {
    on<LoadSavedProducts>(_onLoadSavedProducts);
    on<ToggleSaveProduct>(_onToggleSaveProduct);
  }

  Future<void> _onLoadSavedProducts(
      LoadSavedProducts event,
      Emitter<SavedProductsState> emit,
      ) async {
    emit(state.copyWith(status: SavedProductsStatus.loading));
    final result = await repository.getSavedProducts();
    result.fold(
      onSuccess: (data) => emit(state.copyWith(
        status: SavedProductsStatus.success,
        savedProducts: data,
      )),
      onError: (e) => emit(state.copyWith(
        status: SavedProductsStatus.failure,
        errorMessage: e.toString(),
      )),
    );
  }

  Future<void> _onToggleSaveProduct(
      ToggleSaveProduct event,
      Emitter<SavedProductsState> emit,
      ) async {
    final currentSaved = List<SavedProductsModel>.from(state.savedProducts);
    final isAlreadySaved = currentSaved.any((p) => p.id == event.productId);

    final result = await repository.toggleSaveProduct(event.productId);
    result.fold(
      onSuccess: (_) {
        if (isAlreadySaved) {
          currentSaved.removeWhere((p) => p.id == event.productId);
        } else {
          currentSaved.add(SavedProductsModel(
            id: event.productId,
            categoryId: 0,
            image: 'https://via.placeholder.com/150',
            title: 'Product ${event.productId}',
            price: 0,
            isLiked: true,
            discount: 0,
          ));
        }
        emit(state.copyWith(
          status: SavedProductsStatus.success,
          savedProducts: currentSaved,
        ));
      },
      onError: (e) {
        emit(state.copyWith(
          status: SavedProductsStatus.failure,
          errorMessage: e.toString(),
        ));
      },
    );
  }
}
