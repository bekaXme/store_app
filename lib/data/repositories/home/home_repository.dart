import 'package:store_app/core/services/client.dart';
import 'package:store_app/core/result/result.dart';

import '../../models/home/category_model.dart';
import '../../models/home/product_model.dart';

class HomeRepository {
  final ApiClient client;

  HomeRepository(this.client);

  Future<Result<List<CategoryModel>>> getCategories() async {
    final result = await client.get<List<dynamic>>('/categories/list');
    return result.fold(
      onSuccess: (data) {
        final categories = data.map((e) => CategoryModel.fromJson(e)).toList();
        return Result.success(categories);
      },
      onError: (err) => Result.error(err),
    );
  }

  Future<Result<List<ProductModel>>> getProducts() async {
    final result = await client.get<List<dynamic>>('/products/list');
    return result.fold(
      onSuccess: (data) {
        final products = data.map((e) => ProductModel.fromJson(e)).toList();
        return Result.success(products);
      },
      onError: (err) => Result.error(err),
    );
  }
}
