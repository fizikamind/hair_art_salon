import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/constants/booking_status.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String bookingId;
  final Map<String, dynamic> booking;

  const BookingDetailsScreen({
    super.key,
    required this.bookingId,
    required this.booking,
  });

  Future<void> updateStatus(BuildContext context, String status) async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(bookingId)
        .update({
      'status': status,
    });

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Widget statusButton(
      BuildContext context,
      String text,
      String status,
      Color color,
      ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: () => updateStatus(context, status),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Customer"),
              subtitle: Text(booking['customerName'] ?? ""),
            ),

            ListTile(
              leading: const Icon(Icons.content_cut),
              title: const Text("Service"),
              subtitle: Text(booking['serviceName'] ?? ""),
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Date"),
              subtitle: Text(booking['bookingDate'] ?? ""),
            ),

            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text("Time"),
              subtitle: Text(booking['bookingTime'] ?? ""),
            ),

            ListTile(
              leading: const Icon(Icons.currency_rupee),
              title: const Text("Amount"),
              subtitle: Text("₹${booking['price']}"),
            ),

            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text("Current Status"),
              subtitle: Text(booking['status']),
            ),

            const SizedBox(height: 20),

            statusButton(
              context,
              "Confirm Booking",
              BookingStatus.confirmed,
              Colors.green,
            ),

            statusButton(
              context,
              "Start Service",
              BookingStatus.inProgress,
              Colors.orange,
            ),

            statusButton(
              context,
              "Complete",
              BookingStatus.completed,
              Colors.blue,
            ),

            statusButton(
              context,
              "Cancel",
              BookingStatus.cancelled,
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}