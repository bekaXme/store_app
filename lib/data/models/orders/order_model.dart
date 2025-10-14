class OrderModel {
  final int id;
  final int productId;
  final String title;
  final String size;
  final double price;
  final String status;
  final String image;
  final double rating;

  const OrderModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.size,
    required this.price,
    required this.status,
    required this.image,
    required this.rating,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      title: json['title'] ?? '',
      size: json['size'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'size': size,
      'price': price,
      'status': status,
      'image': image,
      'rating': rating,
    };
  }
}

class OrderListResponse {
  final List<OrderModel> orders;

  const OrderListResponse({required this.orders});

  factory OrderListResponse.fromJson(List<dynamic> json) {
    return OrderListResponse(
      orders: json.map((e) => OrderModel.fromJson(e)).toList(),
    );
  }
}
