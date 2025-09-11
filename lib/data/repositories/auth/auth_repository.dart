import 'package:store_app/core/result/result.dart';
import 'package:store_app/core/services/client.dart';
import '../../models/auth/auth_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<Result<AuthModel>> register(AuthModel user) async {
    final result = await _apiClient.post<Map<String, dynamic>>(
      '/auth/register',
      data: user.toJson(),
    );

    return result.fold(
      onSuccess: (data) => Result.success(AuthModel.fromJson(data)),
      onError: (err) => Result.error(err),
    );
  }

  Future<Result<AuthModel>> login(String email, String password) async {
    final result = await _apiClient.post<Map<String, dynamic>>(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    return result.fold(
      onSuccess: (data) => Result.success(AuthModel.fromJson(data)),
      onError: (err) => Result.error(err),
    );
  }
}
