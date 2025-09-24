import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:store_app/features/notifications/managers/notifications_cubit.dart';
import 'package:store_app/features/notifications/managers/notifications_state.dart';
import 'package:store_app/data/models/notifications/notifications_model.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    if (DateFormat('yyyyMMdd').format(date) ==
        DateFormat('yyyyMMdd').format(now)) {
      return "Today";
    } else if (DateFormat('yyyyMMdd').format(date) ==
        DateFormat('yyyyMMdd').format(yesterday)) {
      return "Yesterday";
    } else {
      return DateFormat('MMMM d, yyyy').format(date); // e.g. June 7, 2023
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications, color: Colors.black),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_none,
                        size: 72, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      'You haven’t gotten any notifications yet!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'We’ll alert you when something cool happens.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            // Group notifications by date
            final grouped = <String, List<NotificationsModel>>{};
            for (var n in state.notifications) {
              final key = _formatDate(n.date);
              grouped.putIfAbsent(key, () => []).add(n);
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: grouped.keys.length,
              itemBuilder: (context, index) {
                final dateKey = grouped.keys.elementAt(index);
                final items = grouped[dateKey]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateKey,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...items.map((notification) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: SvgPicture.network(notification.icon)
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification.content,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
