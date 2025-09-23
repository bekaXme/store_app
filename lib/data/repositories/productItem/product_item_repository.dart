import '../../../core/result/result.dart';
import '../../../core/services/client.dart';
import '../../models/product_detail/product_detail_model.dart';

class ProductDetailRepository {
  final ApiClient _client;

  ProductDetailRepository({required ApiClient apiClient}) : _client = apiClient;

  Future<Result<ProductDetailModel>> getProductDetail(int id) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/products/detail/$id',
    );

    return response.fold(
      onSuccess: (data) => Result.success(ProductDetailModel.fromJson(data)),
      onError: (e) => Result.error(e),
    );
  }
}
