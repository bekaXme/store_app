import '../../../core/result/result.dart';
import '../../../core/services/client.dart';
import '../../models/home/saved_product_model.dart';

class SavedProductsRepository {
  final ApiClient _client;

  SavedProductsRepository({required ApiClient apiClient})
      : _client = apiClient;

  Future<Result<List<SavedProductsModel>>> getSavedProducts() async {
    final response = await _client.get<List<dynamic>>('/products/saved-products');
    return response.fold(
      onSuccess: (data) {
        final saved = data.map((e) => SavedProductsModel.fromJson(e)).toList();
        return Result.success(saved);
      },
      onError: (e) => Result.error(e),
    );
  }

  /// ✅ Like/Unlike product by ID
  Future<Result<void>> toggleSaveProduct(int productId) async {
    final response = await _client.post(
      '/auth/save/$productId',
      data: {}, // depends on your backend, empty body works in many cases
    );

    return response.fold(
      onSuccess: (_) => Result.success(null),
      onError: (e) => Result.error(e),
    );
  }
}
