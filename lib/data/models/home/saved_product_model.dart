class SavedProductsModel {
  final int id;
  final int categoryId;
  final String image;
  final String title;
  final int price;
  final bool isLiked;
  final int discount;

  SavedProductsModel({
    required this.price,
    required this.id,
    required this.categoryId,
    required this.image,
    required this.title,
    required this.isLiked,
    required this.discount,
  });

  factory SavedProductsModel.fromJson(Map<String, dynamic> json) {
    return SavedProductsModel(
      price: json['price'],
      id: json['id'],
      categoryId: json['categoryId'],
      image: json['image'],
      title: json['title'],
      isLiked: json['isLiked'],
      discount: json['discount'],
    );
  }
}
