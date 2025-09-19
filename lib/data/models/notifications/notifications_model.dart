class NotificationsModel {
  final int id;
  final String title;
  final String icon;
  final String content;
  final DateTime date;

  NotificationsModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.content,
    required this.date,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      content: json['content'],
      date: json['date'],
    );
  }
}
