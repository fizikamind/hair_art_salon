import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/booking.dart';
import '../../providers/booking_provider.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final provider =
      Provider.of<BookingProvider>(context, listen: false);

      provider.loadCurrentBookings(uid);
      provider.loadBookingHistory(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Bookings"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Current"),
              Tab(text: "History"),
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            CurrentBookingsTab(),
            BookingHistoryTab(),
          ],
        ),
      ),
    );
  }
}

class CurrentBookingsTab extends StatelessWidget {
  const CurrentBookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        if (provider.currentBookings.isEmpty) {
          return const Center(
            child: Text("No Current Bookings"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: provider.currentBookings.length,
          itemBuilder: (context, index) {
            final Booking booking =
            provider.currentBookings[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(
                  Icons.content_cut,
                  size: 35,
                ),
                title: Text(
                  booking.serviceName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${booking.bookingDate.day}/${booking.bookingDate.month}/${booking.bookingDate.year}\n"
                      "${booking.bookingTime}\n"
                      "${booking.status}",
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
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class BookingHistoryTab extends StatelessWidget {
  const BookingHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        if (provider.bookingHistory.isEmpty) {
          return const Center(
            child: Text("No Booking History"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: provider.bookingHistory.length,
          itemBuilder: (context, index) {
            final Booking booking =
            provider.bookingHistory[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(
                  booking.status == "completed"
                      ? Icons.check_circle
                      : Icons.cancel,
                  color: booking.status == "completed"
                      ? Colors.green
                      : Colors.red,
                  size: 35,
                ),
                title: Text(
                  booking.serviceName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${booking.bookingDate.day}/${booking.bookingDate.month}/${booking.bookingDate.year}\n"
                      "${booking.status}",
                ),
                trailing: Text(
                  "₹${booking.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}