import 'package:store_app/core/services/client.dart';
import 'package:store_app/core/result/result.dart';
import 'package:store_app/data/models/me/me_model.dart';

class MyInfoRepository {
  final ApiClient _client;

  MyInfoRepository({required ApiClient client}) : _client = client;

  Future<Result<MeModel>> getMyInfo() async {
    final result = await _client.get<Map<String, dynamic>>('/auth/me');
    return result.fold(
      onSuccess: (data) {
        final myInfo = MeModel.fromJson(data);
        return Result.success(myInfo);
      },
      onError: (err) => Result.error(err),
    );
  }
}
