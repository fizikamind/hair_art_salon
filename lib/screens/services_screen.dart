import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Services Screen',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}