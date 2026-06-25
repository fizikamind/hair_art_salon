import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const HairArtSalonApp());
}

class HairArtSalonApp extends StatelessWidget {
  const HairArtSalonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hair Art Salon',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}