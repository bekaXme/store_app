import 'package:equatable/equatable.dart';
import '../../data/models/notifications/notifications_model.dart';

enum NotificationsStatus { initial, loading, success, failure }

class NotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<NotificationsModel> notifications;
  final String? error;

  const NotificationsState({
    required this.status,
    required this.notifications,
    this.error,
  });

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<NotificationsModel>? notifications,
    String? error,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, notifications, error];
}
