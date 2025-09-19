import 'package:store_app/core/result/result.dart';
import 'package:store_app/core/services/client.dart';
import 'package:store_app/data/models/notifications/notifications_model.dart';

class NotificationRepository {
  final ApiClient apiClient;

  NotificationRepository(this.apiClient);

  Future<Result<List<NotificationsModel>>> getNotifications() async {
    final result = await apiClient.get<List<dynamic>>("/notifications/list");
    return result.fold(
      onSuccess: (data) {
        final notifications = data
            .map((e) => NotificationsModel.fromJson(e))
            .toList();
        return Result.success(notifications);
      },
      onError: (e) {
        return Result.error(e);
      },
    );
  }
}
