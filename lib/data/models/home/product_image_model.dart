class ProductImagesModel {
  final int id;
  final String image;

  ProductImagesModel({
    required this.id,
    required this.image,
  });

  factory ProductImagesModel.fromJson(Map<String, dynamic> json) {
    return ProductImagesModel(
      id: json['id'],
      image: json['image'],
    );
  }
}
