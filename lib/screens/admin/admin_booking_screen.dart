import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'booking_details_screen.dart';

class AdminBookingScreen extends StatelessWidget {
  const AdminBookingScreen({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      case 'in_progress':
        return Colors.orange;
      default:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookings"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .orderBy('bookingTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error loading bookings"),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final bookings = snapshot.data!.docs;

          if (bookings.isEmpty) {
            return const Center(
              child: Text("No Bookings"),
            );
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking =
              bookings[index].data() as Map<String, dynamic>;

              final status = booking['status'] ?? "pending";

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: Text(
                    booking['customerName'] ?? '',
                  ),
                  subtitle: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(booking['serviceName'] ?? ''),
                      Text(booking['time'] ?? ''),
                      Text("₹${booking['price']}"),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(status),
                    backgroundColor:
                    getStatusColor(status),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingDetailsScreen(
                          bookingId: bookings[index].id,
                          booking: booking,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showStatusDialog(
      BuildContext context,
      String bookingId,
      ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Update Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListTile(
              title: const Text("Pending"),
              onTap: () =>
                  updateStatus(bookingId, "pending", context),
            ),

            ListTile(
              title: const Text("Confirmed"),
              onTap: () =>
                  updateStatus(bookingId, "confirmed", context),
            ),

            ListTile(
              title: const Text("In Progress"),
              onTap: () => updateStatus(
                  bookingId,
                  "in_progress",
                  context),
            ),

            ListTile(
              title: const Text("Completed"),
              onTap: () =>
                  updateStatus(bookingId, "completed", context),
            ),

            ListTile(
              title: const Text("Cancelled"),
              onTap: () =>
                  updateStatus(bookingId, "cancelled", context),
            ),
          ],
        ),
      ),
    );
  }

  void updateStatus(
      String bookingId,
      String status,
      BuildContext context,
      ) async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(bookingId)
        .update({
      'status': status,
    });

    Navigator.pop(context);
  }
}