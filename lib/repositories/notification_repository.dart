import '../models/notification_model.dart';
import '../services/notification_firestore.dart';

class NotificationRepository {
  final NotificationFirestore _notificationFirestore =
  NotificationFirestore();

  /// Add Notification
  Future<void> addNotification(
      NotificationModel notification) async {
    await _notificationFirestore.addNotification(notification);
  }

  /// Get User Notifications
  Stream<List<NotificationModel>> getNotifications(
      String userId) {
    return _notificationFirestore.getNotifications(userId);
  }

  /// Mark Notification as Read
  Future<void> markAsRead(
      String notificationId) async {
    await _notificationFirestore.markAsRead(notificationId);
  }

  /// Delete Notification
  Future<void> deleteNotification(
      String notificationId) async {
    await _notificationFirestore.deleteNotification(notificationId);
  }
}