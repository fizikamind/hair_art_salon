import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notification_model.dart';

class NotificationFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _collection = "notifications";

  /// Add Notification
  Future<void> addNotification(NotificationModel notification) async {
    await _firestore
        .collection(_collection)
        .add(notification.toMap());
  }

  /// Get Notifications of a User
  Stream<List<NotificationModel>> getNotifications(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return NotificationModel.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }

  /// Mark Notification as Read
  Future<void> markAsRead(String notificationId) async {
    await _firestore
        .collection(_collection)
        .doc(notificationId)
        .update({
      'isRead': true,
    });
  }

  /// Delete Notification
  Future<void> deleteNotification(String notificationId) async {
    await _firestore
        .collection(_collection)
        .doc(notificationId)
        .delete();
  }
}