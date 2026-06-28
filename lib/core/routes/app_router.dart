import 'package:go_router/go_router.dart';
import 'package:hair_art_salon/screens/customers/customer_screen.dart';

import '../../screens/home/home_screen.dart';
import '../../screens/splash/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/customers',
      builder: (context, state) => const CustomerScreen(),
    ),
  ],
);