class MeModel {
  final int id;
  final String fullName;
  final String email;
  final int? phoneNumber;
  final String? gender;
  final DateTime? birthDate;

  MeModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.gender,
    this.birthDate,
  });

  factory MeModel.fromJson(Map<String, dynamic> json) {
    return MeModel(
      id: json['id'],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"], // null-safe
      gender: json["gender"],
      birthDate: json["birthDate"] != null ? DateTime.parse(json["birthDate"]) : null,
    );
  }
}
