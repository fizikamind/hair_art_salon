import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

import 'providers/auth_provider.dart';

import 'screens/login/login_screen.dart';
import 'providers/service_provider.dart';
import 'screens/main_screen.dart';
import 'providers/booking_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'screens/admin/admin_dashboard.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hair Art Salon',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {

          if (!authSnapshot.hasData) {
            return const LoginScreen();
          }

          final uid = authSnapshot.data!.uid;

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .get(),

            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (!snapshot.data!.exists) {
                return const LoginScreen();
              }

              final data =
              snapshot.data!.data() as Map<String, dynamic>;

              if (data['role'] == 'admin') {
                return const AdminDashboard();
              }

              return const MainScreen();
            },
          );
        },
      ),
    );
  }
}