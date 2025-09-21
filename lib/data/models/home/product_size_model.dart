class ProductSizesModel {
  final int id;
  final String title;

  ProductSizesModel({
    required this.id,
    required this.title,
  });

  factory ProductSizesModel.fromJson(Map<String, dynamic> json) {
    return ProductSizesModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
