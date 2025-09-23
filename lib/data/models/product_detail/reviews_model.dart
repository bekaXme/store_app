class ReviewsModel {
  final int id;
  final String comment;
  final int rating;
  final DateTime created;
  final String userFullName;

  ReviewsModel({
    required this.id,
    required this.comment,
    required this.rating,
    required this.created,
    required this.userFullName,
  });

  factory ReviewsModel.toJson(Map<String, dynamic> json) {
    return ReviewsModel(
      id: json['id'],
      comment: json['comment'],
      rating: json['rating'],
      created: DateTime.parse(json['created']),
      userFullName: json['userFullName'],
    );
  }
}
