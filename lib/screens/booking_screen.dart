import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Booking'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Booking Screen',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}