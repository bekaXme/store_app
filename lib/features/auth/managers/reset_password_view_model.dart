import 'package:flutter/material.dart';

import '../../../data/repositories/auth/auth_repository.dart';
class ResetPasswordVM extends ChangeNotifier {
  final AuthRepository _authRepository;
  bool isLoading = false;
  String? error;

  ResetPasswordVM(this._authRepository);

  Future<bool> fetchResetPassword(String email) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _authRepository.resetPassword(email);
    isLoading = false;
    notifyListeners();

    return result.fold(
      onError: (err) {
        error = error;
        return false;
      },
      onSuccess: (_) => true,
    );
  }

  Future<bool> fetchVerifyOtp(String email, String code) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _authRepository.verifyOtp(email, code);
    isLoading = false;
    notifyListeners();

    return result.fold(
      onError: (err) {
        error = error;
        return false;
      },
      onSuccess: (ok) => ok,
    );
  }

  Future<bool> fetchChangePassword(String password, String code, String email) async {
    isLoading = true;
    error = null;
    notifyListeners();
    final result = await _authRepository.changePassword(password, code, email);
    isLoading = false;
    notifyListeners();
    return result.fold(
      onError: (err) {
        error = error;
        return false;
      },
      onSuccess: (ok) => ok,
    );
  }
}
