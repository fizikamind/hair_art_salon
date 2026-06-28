import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/booking_provider.dart';
import 'add_booking_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      Provider.of<BookingProvider>(
        context,
        listen: false,
      ).loadCurrentBookings(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookings"),
      ),

      body: provider.bookings.isEmpty
          ? const Center(
        child: Text(
          "No Bookings Yet",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: provider.bookings.length,
        itemBuilder: (context, index) {
          final booking = provider.bookings[index];

          return Card(
            margin: const EdgeInsets.all(8),

            child: ListTile(
              leading: const Icon(
                Icons.calendar_today,
              ),

              title: Text(
                booking.customerName,
              ),

              subtitle: Text(
                "${booking.serviceName}\n${booking.bookingTime}",
              ),

              trailing: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    "₹${booking.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(booking.status),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddBookingScreen(),
            ),
          );
        },
      ),
    );
  }
}