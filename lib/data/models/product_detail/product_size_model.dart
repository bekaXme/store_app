class ProductSizeModel {
  final int id;
  final String title;

  ProductSizeModel({required this.id, required this.title});

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) {
    return ProductSizeModel(
      id: json['id'],
      title: json['title'] ?? '',
    );
  }
}
