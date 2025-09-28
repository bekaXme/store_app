class SearchModel {
  final int id;
  final String title;
  final int price;
  final int discount;
  final String image;

  SearchModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.discount,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? "",
      image: json['image']?.toString() ?? "",
      price: (json['price'] is int)
          ? json['price'] as int
          : int.tryParse(json['price']?.toString() ?? "0") ?? 0,
      discount: (json['discount'] is int)
          ? json['discount'] as int
          : int.tryParse(json['discount']?.toString() ?? "0") ?? 0,
    );
  }
}
