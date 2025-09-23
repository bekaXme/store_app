import '../../../data/models/home/category_model.dart';
import '../../../data/models/product_detail/product_model.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final String? error;

  const HomeState({
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.products = const [],
    this.error,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, categories, products, error];
}
