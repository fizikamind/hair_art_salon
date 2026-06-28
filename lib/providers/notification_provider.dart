import 'package:flutter/material.dart';

import '../models/notification_model.dart';
import '../repositories/notification_repository.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository _repository =
  NotificationRepository();

  List<NotificationModel> notifications = [];

  /// Load Notifications
  void loadNotifications(String userId) {
    _repository.getNotifications(userId).listen((data) {
      notifications = data;
      notifyListeners();
    });
  }

  /// Add Notification
  Future<void> addNotification(
      NotificationModel notification) async {
    await _repository.addNotification(notification);
  }

  /// Mark as Read
  Future<void> markAsRead(
      String notificationId) async {
    await _repository.markAsRead(notificationId);
  }

  /// Delete Notification
  Future<void> deleteNotification(
      String notificationId) async {
    await _repository.deleteNotification(notificationId);
  }

  /// Unread Count
  int get unreadCount =>
      notifications.where((n) => !n.isRead).length;
}