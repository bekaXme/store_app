class AddressModel {
  final String nickname;
  final String fullAddress;
  final double? lat; // Made nullable
  final double? lng; // Made nullable
  final bool isDefault;
  final int? id;

  AddressModel({
    required this.nickname,
    required this.fullAddress,
    this.lat,
    this.lng,
    required this.isDefault,
    this.id,
  });

  AddressModel copyWith({
    String? nickname,
    String? fullAddress,
    double? lat,
    double? lng,
    bool? isDefault,
    int? id,
  }) {
    return AddressModel(
      nickname: nickname ?? this.nickname,
      fullAddress: fullAddress ?? this.fullAddress,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isDefault: isDefault ?? this.isDefault,
      id: id ?? this.id,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      nickname: json['nickname'] ?? 'Unknown',
      // Provide default if null
      fullAddress: json['fullAddress'] ?? 'No address provided',
      // Provide default if null
      isDefault: json['isDefault'] ?? false,
      id: json['id'],
      lat: json['lat'] != null ? (json['lat'] as num?)?.toDouble() : null,
      // Handle null
      lng: json['lng'] != null
          ? (json['lng'] as num?)?.toDouble()
          : null, // Handle null
    );
  }

  Map<String, dynamic> toJson() => {
    "nickname": nickname,
    "fullAddress": fullAddress,
    "isDefault": isDefault,
    "lat": lat,
    "lng": lng,
    "id": id,
  };
}
