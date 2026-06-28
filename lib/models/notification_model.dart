class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String message;
  final String type;
  final String? bookingId;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    this.bookingId,
    required this.isRead,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'message': message,
      'type': type,
      'bookingId': bookingId,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory NotificationModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return NotificationModel(
      id: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      type: map['type'] ?? '',
      bookingId: map['bookingId'],
      isRead: map['isRead'] ?? false,
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
    );
  }
}