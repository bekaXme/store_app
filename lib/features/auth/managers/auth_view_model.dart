import 'package:flutter/cupertino.dart';
import '../../../data/models/auth/auth_model.dart';
import '../../../data/repositories/auth/auth_repository.dart';

class AuthVM extends ChangeNotifier {
  final AuthRepository _authRepository;
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
      onSuccess: (data) {
        try {
          user = AuthModel.fromJson(data as Map<String, dynamic>); // assign to field, not local var
        } catch (e) {
          error = "Parsing error: $e";
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

    final result = await _authRepository.login(authModel.email, authModel.password!);
    result.fold(
      onError: (err) {
        error = err.toString();
      },
      onSuccess: (data) {
        try {
          user = AuthModel.fromJson(data as Map<String, dynamic>); // same parsing fix
        } catch (e) {
          error = "Parsing error: $e";
        }
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
