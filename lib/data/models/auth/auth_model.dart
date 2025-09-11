class AuthModel {
  String? fullName;
  String email;
  String? password; // make it nullable
  String? token;

  AuthModel({
    required this.fullName,
    required this.email,
    this.password,
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    fullName: json['fullName'] ?? "",
    email: json['email'] ?? "",
    password: json['password'],
    token:
        json['accessToken'] ??
        json['token'],
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    if (password != null) 'password': password, // only send when available
  };
}
