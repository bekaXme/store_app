import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/models/auth/auth_model.dart';
import '../../../data/repositories/auth/auth_repository.dart';

class AuthVM extends ChangeNotifier {
  final AuthRepository _authRepository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  bool isLoading = false;
  String? error;
  AuthModel? user;

  AuthVM(this._authRepository);

  Future<void> fetchRegister(AuthModel newUser) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _authRepository.register(newUser);
    result.fold(
      onError: (err) {
        error = err.toString();
      },
      onSuccess: (data) async {
        user = data;
        if (data.token != null) {
          await _storage.write(key: "accessToken", value: data.token!);
        }
      },
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchLogin(AuthModel authModel) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result =
    await _authRepository.login(authModel.email, authModel.password!);
    result.fold(
      onError: (err) {
        error = err.toString();
      },
      onSuccess: (data) async {
        user = data;
        if (data.token != null) {
          await _storage.write(key: "accessToken", value: data.token!);
        }
      },
    );

    isLoading = false;
    notifyListeners();
  }

  /// Get token when needed
  Future<String?> getToken() async {
    return await _storage.read(key: "accessToken");
  }

  /// Clear token on logout
  Future<void> logout() async {
    await _storage.delete(key: "accessToken");
    user = null;
    notifyListeners();
  }
}
