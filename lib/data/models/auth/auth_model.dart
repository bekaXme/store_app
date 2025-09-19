class AuthModel {
  final String? fullName;
  final String email; // keep consistent for register
  final String? password;
  final String? token;

  AuthModel({
    this.fullName,
    required this.email,
    this.password,
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      fullName: json['fullName'],
      email: json['email'] ?? "",
      password: json['password'],
      token: json['accessToken'],
    );
  }

  /// For register
  Map<String, dynamic> toRegisterJson() {
    return {
      if (fullName != null) 'fullName': fullName,
      'email': email,
      if (password != null) 'password': password,
    };
  }

  /// For login
  Map<String, dynamic> toLoginJson() {
    return {
      'login': email,
      if (password != null) 'password': password,
    };
  }

  @override
  String toString() {
    return 'AuthModel(email: $email, token: $token)';
  }
}
