import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubit/notifications/notifications_state.dart';

import '../../data/repositories/notifications/notifications_repository.dart';

class NotificationsCubit extends Cubit<NotificationsState>{
  final NotificationRepository repository;

  NotificationsCubit(this.repository) : super(NotificationsState(
    status: NotificationsStatus.loading,
    notifications: []
  ));

  Future<void> loadData() async {
    emit(state.copyWith(status: NotificationsStatus.loading));
    try {
      final categoriesResult = await repository.getNotifications();
      categoriesResult.fold(
        onSuccess: (notifications) {
          emit(
            state.copyWith(
              status: NotificationsStatus.success,
              notifications: notifications,
            ),
          );
        },
        onError: (err) {
          emit(
            state.copyWith(
              status: NotificationsStatus.failure,
              error: err.toString(),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationsStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
