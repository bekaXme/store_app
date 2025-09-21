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
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      content: json['content'] ?? '',
      date: DateTime.tryParse(json['date'].toString()) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "icon": icon,
      "content": content,
      "date": date.toIso8601String(),
    };
  }
}
