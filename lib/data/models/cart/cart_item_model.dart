class CartItemModel {
  final int id;
  final int productId;
  final String title;
  final String size;
  final int price;
  final String image;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.size,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] is String ? int.parse(json['id']) : json['id'] ?? 0,
      productId: json['productId'] is String ? int.parse(json['productId']) : json['productId'] ?? 0,
      title: json['title'] ?? '',
      size: json['size'] ?? '',
      price: json['price'] is String ? int.parse(json['price']) : json['price'] ?? 0,
      image: json['image'] ?? '',
      quantity: json['quantity'] is String ? int.parse(json['quantity']) : json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "title": title,
    "size": size,
    "price": price,
    "image": image,
    "quantity": quantity,
  };

  CartItemModel copyWith({
    int? id,
    int? productId,
    String? title,
    String? size,
    int? price,
    String? image,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      size: size ?? this.size,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartResponse {
  final List<CartItemModel> items;
  final int subTotal;
  final int vat;
  final int shippingFee;
  final int total;

  CartResponse({
    required this.items,
    required this.subTotal,
    required this.vat,
    required this.shippingFee,
    required this.total,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subTotal: json['subTotal'] is String ? int.parse(json['subTotal']) : json['subTotal'] ?? 0,
      vat: json['vat'] is String ? int.parse(json['vat']) : json['vat'] ?? 0,
      shippingFee: json['shippingFee'] is String ? int.parse(json['shippingFee']) : json['shippingFee'] ?? 0,
      total: json['total'] is String ? int.parse(json['total']) : json['total'] ?? 0,
    );
  }

  CartResponse copyWith({
    List<CartItemModel>? items,
    int? subTotal,
    int? vat,
    int? shippingFee,
    int? total,
  }) {
    return CartResponse(
      items: items ?? this.items,
      subTotal: subTotal ?? this.subTotal,
      vat: vat ?? this.vat,
      shippingFee: shippingFee ?? this.shippingFee,
      total: total ?? this.total,
    );
  }
}
