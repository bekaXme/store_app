import '../../../data/repositories/home/home_repository.dart';
import 'home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(const HomeState());

  Future<void> loadData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final categoriesResult = await repository.getCategories();
      final productsResult = await repository.getProducts();
      categoriesResult.fold(
        onSuccess: (categories) {
          productsResult.fold(
            onSuccess: (products) {
              emit(state.copyWith(
                status: HomeStatus.success,
                categories: categories,
                products: products,
              ));
            },
            onError: (err) {
              emit(state.copyWith(status: HomeStatus.failure, error: err.toString()));
            },
          );
        },
        onError: (err) {
          emit(state.copyWith(status: HomeStatus.failure, error: err.toString()));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, error: e.toString()));
    }
  }
}
