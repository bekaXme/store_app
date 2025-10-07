class AddressModel {
  final String title;
  final String fullAddress;
  final double lat;
  final double lng;
  final bool isDefault;

  AddressModel({
    required this.title,
    required this.fullAddress,
    required this.isDefault,
    required this.lat,
    required this.lng,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      title: json['title'],
      fullAddress: json['fullAddress'],
      isDefault: json['isDefault'],
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "title" : title,
    "fullAddress" : fullAddress,
    "isDefault" : isDefault,
    "lat" : lat,
    "lng" : lng
  };
}
