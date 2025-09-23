class ProductDetailModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final bool isLiked;
  final List<String> productImages;
  final List<String> productSizes;
  final int reviewsCount;
  final double rating;

  ProductDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.isLiked,
    required this.productImages,
    required this.productSizes,
    required this.reviewsCount,
    required this.rating,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      isLiked: json['isLiked'] ?? false,
      productImages: (json['productImages'] as List)
          .map((e) => e['image'] as String)
          .toList(),
      productSizes:
      (json['productSizes'] as List).map((e) => e['title'] as String).toList(),
      reviewsCount: json['reviewsCount'] ?? 0,
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
