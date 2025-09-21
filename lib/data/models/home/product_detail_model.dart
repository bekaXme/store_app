class ProductDetailModel {
  final int id;
  final String title;
  final String description;
  final bool isLiked;
  final int reviewCount;
  final num rating;

  ProductDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isLiked,
    required this.reviewCount,
    required this.rating,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isLiked: json['isLiked'],
      reviewCount: json['reviewCount'],
      rating: json['rating'],
    );
  }
}


