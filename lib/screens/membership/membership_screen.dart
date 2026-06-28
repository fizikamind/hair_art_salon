import 'package:flutter/material.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Membership Screen',
          style: TextStyle(color: Colors.amber, fontSize: 24),
        ),
      ),
    );
  }
}