import 'package:store_app/core/result/result.dart';
import 'package:store_app/data/models/search/search_model.dart';
import '../../../core/services/client.dart';


class SearchRepository {
  final ApiClient _apiClient;

  SearchRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<SearchModel>>> getSearchItems() async {
    final response = await _apiClient.get('/products/list?Title=a');
    return response.fold(
      onError: (error) => Result.error(error),
      onSuccess: (data) {
        final saved = data.map((e) => SearchModel.fromJson(e)).toList();
        return Result.success(saved);
      },
    );
  }
}
