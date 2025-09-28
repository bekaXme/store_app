import 'package:store_app/core/result/result.dart';
import 'package:store_app/data/models/search/search_model.dart';
import '../../../core/services/client.dart';

class SearchRepository {
  final ApiClient _apiClient;

  SearchRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<SearchModel>>> getSearchItems(String query) async {
    final response = await _apiClient.get('/products/list?Title=$query');
    return response.fold(
      onError: (error) => Result.error(error),
      onSuccess: (data) {
        if (data is List) {
          final saved = data
              .map((e) => SearchModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Result.success(saved);
        } else if (data is Map && data['data'] is List) {
          final saved = (data['data'] as List)
              .map((e) => SearchModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Result.success(saved);
        } else {
          return Result.error(Exception("Invalid response format"));
        }
      },
    );
  }
}
