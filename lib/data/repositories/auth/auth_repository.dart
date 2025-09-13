import 'package:store_app/core/result/result.dart';
import 'package:store_app/core/services/client.dart';
import '../../models/auth/auth_model.dart';

class AuthRepository {
  final ApiClient? _apiClient;

  AuthRepository(this._apiClient);

  Future<Result<AuthModel>> register(AuthModel user) async {
    final result = await _apiClient!.post<Map<String, dynamic>>(
      '/auth/register',
      data: user.toJson(),
    );
    return result.fold(
      onSuccess: (data) => Result.success(AuthModel.fromJson(data)),
      onError: (err) => Result.error(err),
    );
  }

  Future<Result<AuthModel>> login(String email, String password) async {
    final result = await _apiClient!.post<Map<String, dynamic>>(
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

  Future<Result<bool>> resetPassword(String email) async {
    final result = await _apiClient!.post<bool>(
      '/auth/reset-password/email',
      data: {'email': email},
    );
    return result.fold(
      onSuccess: (_) => Result.success(true), // only need success bool
      onError: (err) => Result.error(err),
    );
  }

  Future<Result<bool>> verifyOtp(String email, String code) async {
    final result = await _apiClient!.post<bool>(
      '/auth/reset-password/verify',
      data: {
        "email": email,
        "code": code,
      },
    );
    return result.fold(
      onSuccess: (data) => Result.success(data),
      onError: (err) => Result.error(err),
    );
  }

  Future<Result<bool>> changePassword(String password, String code, String email) async {
    final result = await _apiClient!.post<bool>(
      '/auth/reset-password/reset',
      data: {
        "email": email,
        "code": code,
        "password": password,
      },
    );
    return result.fold(
      onSuccess: (data) => Result.success(data),
      onError: (err) => Result.error(err),
    );
  }
}
