import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}