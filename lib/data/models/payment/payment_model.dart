class CardModel {
  final int? id;
  final String cardNumber;
  final String expiryDate;
  final String securityCode;
  final String? cardHolderName;

  CardModel({
    this.id,
    required this.cardNumber,
    required this.expiryDate,
    required this.securityCode,
    this.cardHolderName,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      cardNumber: json['cardNumber'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      securityCode: json['securityCode'] ?? '',
      cardHolderName: json['cardHolderName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'securityCode': securityCode,
      if (cardHolderName != null) 'cardHolderName': cardHolderName,
    };
  }
}
