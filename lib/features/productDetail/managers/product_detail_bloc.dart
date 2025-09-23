import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/result/result.dart';
import '../../../data/repositories/productItem/product_item_repository.dart';
import '../../savedProducts/bloc/saved_products_state.dart';
import 'product_detail_state.dart';
part  "product_detail_event.dart";

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailRepository repository;



  ProductDetailBloc({required this.repository})
      : super(ProductDetailState.initial()) {
    on<GetProductId>(_onGetProductId);
  }

  Future<void> _onGetProductId(
      GetProductId event,
      Emitter<ProductDetailState> emit,
      ) async {
    emit(state.copyWith(productStatus: SavedProductsStatus.loading, errorProduct: null));

    final result = await repository.getProductDetail(event.id);

    result.fold(
      onSuccess: (product) {
        emit(state.copyWith(
          productStatus: SavedProductsStatus.success,
          product: product,
        ));
      },
      onError: (e) {
        emit(state.copyWith(
          productStatus: SavedProductsStatus.failure,
          errorProduct: e.toString(),
        ));
      },
    );
  }
}
