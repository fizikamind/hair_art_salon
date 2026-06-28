import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/notification_model.dart';
import '../../providers/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState
    extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Future.microtask(() {
        Provider.of<NotificationProvider>(
          context,
          listen: false,
        ).loadNotifications(user.uid);
      });
    }
  }

  IconData _getIcon(String type) {
    switch (type.toLowerCase()) {
      case "booking":
        return Icons.calendar_month;

      case "offer":
        return Icons.local_offer;

      case "membership":
        return Icons.workspace_premium;

      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),

      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {

          if (provider.notifications.isEmpty) {
            return const Center(
              child: Text(
                "No Notifications",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.notifications.length,

            itemBuilder: (context, index) {

              final NotificationModel notification =
              provider.notifications[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),

                color: notification.isRead
                    ? null
                    : Colors.blue.withOpacity(0.08),

                child: ListTile(

                  leading: CircleAvatar(
                    child: Icon(
                      _getIcon(notification.type),
                    ),
                  ),

                  title: Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    notification.message,
                  ),

                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {

                      if (value == "read") {

                        await provider.markAsRead(
                          notification.id,
                        );

                      } else if (value == "delete") {

                        await provider.deleteNotification(
                          notification.id,
                        );
                      }
                    },

                    itemBuilder: (context) => [

                      if (!notification.isRead)
                        const PopupMenuItem(
                          value: "read",
                          child: Text("Mark as Read"),
                        ),

                      const PopupMenuItem(
                        value: "delete",
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}