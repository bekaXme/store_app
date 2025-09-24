class SearchModel {
  final String title;
  final int price;
  final int discount;

  SearchModel({
    required this.title,
    required this.price,
    required this.discount,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      title: json['title'] ?? "",
      price: json['price'] ?? "",
      discount: json['discount'] ?? "",
    );
  }
}
