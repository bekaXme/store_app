import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/savedProducts/bloc/saved_products_state.dart';
import '../../../data/models/home/saved_product_model.dart';
import '../../../data/repositories/savedProducts/saved_products_repository.dart';

class SavedCubit extends Cubit<SavedState> {
  final SavedProductsRepository _repo;

  SavedCubit({required SavedProductsRepository productRepo})
    : _repo = productRepo,
      super(SavedState.initial()) {
    fetchSavedProducts();
  }

  Future<void> fetchSavedProducts() async {
    emit(state.copyWith(status: Status.loading));
    final result = await _repo.getSavedProducts();
    result.fold(
      onError: (error) => emit(
        state.copyWith(
          status: Status.error,
          errorSavedMessage: error.toString(),
        ),
      ),
      onSuccess: (value) =>
          emit(state.copyWith(status: Status.success, savedProducts: value)),
    );
  }

  Future<void> toggleSave(int productId) async {
    // Optimistic update
    final isAlreadySaved = state.savedProducts.any((p) => p.id == productId);

    List<SavedProductsModel> updatedList;
    if (isAlreadySaved) {
      updatedList = state.savedProducts
          .where((p) => p.id != productId)
          .toList();
    } else {
      updatedList = [
        ...state.savedProducts,
        SavedProductsModel(
          price: 0,
          id: productId,
          categoryId: productId,
          image: "",
          title: "",
          isLiked: false,
          discount: 0,
        ),
      ];
      // 👆 you can fill with real product details if you have them
    }

    emit(state.copyWith(savedProducts: updatedList, status: Status.success));

    // Call API
    final result = await _repo.toggleSaveProduct(productId);

    result.fold(
      onError: (e) {
        // rollback if failed
        emit(
          state.copyWith(errorSavedMessage: e.toString(), status: Status.error),
        );
        fetchSavedProducts();
      },
      onSuccess: (_) async {
        // ensure synced with backend
        await fetchSavedProducts();
      },
    );
  }
}
