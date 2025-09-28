class CardModel {
  final int id; // Add id field
  final String cardNumber;
  final String expiryDate;
  final String securityCode;

  CardModel({
    required this.id,
    required this.cardNumber,
    required this.expiryDate,
    required this.securityCode,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] is String ? int.parse(json['id']) : json['id'] ?? 0, // Handle string or int
      cardNumber: json['cardNumber'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      securityCode: json['securityCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include id in JSON
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'securityCode': securityCode,
    };
  }
}