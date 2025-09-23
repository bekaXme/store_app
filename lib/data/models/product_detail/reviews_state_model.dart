class ReviewsStatsModel {
  final int totalCount;
  final int fiveStars;
  final int fourStars;
  final int threeStars;
  final int twoStars;
  final int oneStars;

  ReviewsStatsModel({
    required this.totalCount,
    required this.fiveStars,
    required this.fourStars,
    required this.threeStars,
    required this.twoStars,
    required this.oneStars,
  });

  factory ReviewsStatsModel.toJson(Map<String, dynamic> json) {
    return ReviewsStatsModel(
      totalCount: json['totalCount'],
      fiveStars: json['fiveStars'],
      fourStars: json['fourStars'],
      threeStars: json['threeStars'],
      twoStars: json['twoStars'],
      oneStars: json['oneStars'],
    );
  }
}
