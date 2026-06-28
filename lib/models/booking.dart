class Booking {
  final String? id;
  final String customerId;
  final String customerName;
  final String serviceId;
  final String serviceName;
  final DateTime bookingDate;
  final String bookingTime;
  final double price;
  final String status;
  final String notes;
  final DateTime createdAt;

  Booking({
    this.id,
    required this.customerId,
    required this.customerName,
    required this.serviceId,
    required this.serviceName,
    required this.bookingDate,
    required this.bookingTime,
    required this.price,
    required this.status,
    required this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'bookingDate': bookingDate.toIso8601String(),
      'bookingTime': bookingTime,
      'price': price,
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Booking.fromMap(String id, Map<String, dynamic> map) {
    return Booking(
      id: id,
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      serviceId: map['serviceId'] ?? '',
      serviceName: map['serviceName'] ?? '',
      bookingDate: DateTime.parse(map['bookingDate']),
      bookingTime: map['bookingTime'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      status: map['status'] ?? 'pending',
      notes: map['notes'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}