import 'package:flutter/material.dart';
import 'admin_booking_screen.dart';
import '../../services/auth_service.dart';
import 'admin_service_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
            },
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [

          _AdminCard(
            icon: Icons.calendar_month,
            title: "Bookings",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminBookingScreen(),
                ),
              );
            },
          ),

          _AdminCard(
            icon: Icons.content_cut,
            title: "Services",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminServiceScreen(),
                ),
              );
            },
          ),

          _AdminCard(
            icon: Icons.content_cut,
            title: "Services",
            onTap: () {
              print("Services button pressed");

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminServiceScreen(),
                ),
              );
            },
          ),

          _AdminCard(
            icon: Icons.workspace_premium,
            title: "Membership",
            onTap: () {},
          ),

          _AdminCard(
            icon: Icons.local_offer,
            title: "Offers",
            onTap: () {},
          ),

          _AdminCard(
            icon: Icons.settings,
            title: "Settings",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _AdminCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AdminCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 50,
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}