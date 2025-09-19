import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubit/notifications/notifications_cubit.dart';
import 'package:store_app/cubit/notifications/notifications_state.dart';
import 'package:store_app/data/models/notifications/notifications_model.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: const [Icon(Icons.notifications)],
      ),
      body: Column(
        children: [
          const Divider(color: Colors.black),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state.status == NotificationsStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == NotificationsStatus.failure) {
                  return Center(
                    child: Text(state.error ?? "Something went wrong"),
                  );
                }
                if (state.status == NotificationsStatus.success) {
                  if (state.notifications.isEmpty) {
                    return const Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.notifications,
                            size: 64,
                            color: Colors.grey,
                          ),
                          Text(
                            'You haven’t gotten any notifications yet!',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'We’ll alert you when something cool happens.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: state.notifications.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: Colors.grey),
                    itemBuilder: (context, index) {
                      final NotificationsModel notification =
                          state.notifications[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            notification.icon,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        title: Text(
                          notification.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(notification.content),
                        trailing: Text(
                          "${notification.date.day}/${notification.date.month}/${notification.date.year}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox(); // fallback
              },
            ),
          ),
        ],
      ),
    );
  }
}
