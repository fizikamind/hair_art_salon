import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_animation.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

import '../../widgets/buttons/primary_button.dart';
import '../../widgets/cards/premium_card.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/navigation/premium_app_bar.dart';

import '../booking/add_booking_screen.dart';
import '../booking/my_bookings_screen.dart';
import '../notifications/notification_screen.dart';
import '../services/service_list_screen.dart';
import '../../widgets/cards/quick_action_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning ☀";
    }

    if (hour < 17) {
      return "Good Afternoon ☀";
    }

    return "Good Evening 🌙";
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: PremiumAppBar(
        title: "Hair Art Salon",
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.primary,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const NotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedContainer(
          duration: AppAnimation.normal,
          curve: AppAnimation.easeInOut,
          child: ListView(
            padding: AppSpacing.pagePadding,
            children: [

              Text(
                _greeting(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),

              AppSpacing.h8,

              Text(
                "Hello, ${user?.displayName ?? "Customer"} 👋",
                style: AppTextStyles.headlineMedium,
              ),

              AppSpacing.h4,

              Text(
                "Welcome back to Hair Art Salon",
                style: AppTextStyles.bodySmall,
              ),

              AppSpacing.h24,

              SectionHeader(
                title: "Upcoming Appointment",
              ),

              AppSpacing.h12,

              PremiumCard(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: const [

                        Icon(
                          Icons.calendar_month,
                          color: AppColors.primary,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "No Upcoming Booking",
                          style:
                              AppTextStyles.cardTitle,
                        ),

                      ],
                    ),

                    AppSpacing.h16,

                    Text(
                      "Book your next appointment with our professional stylists.",
                      style:
                          AppTextStyles.bodyMedium,
                    ),

                    AppSpacing.h20,

                    PrimaryButton(
                      text: "BOOK APPOINTMENT",
                      icon: Icons.calendar_month,
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const AddBookingScreen(),
                          ),
                        );
                      },
                    ),

                  ],
                ),
              ),

              AppSpacing.h32,

              const SectionHeader(
                title: "Quick Actions",
              ),

              AppSpacing.h16,
              GridView.count(
                physics:
                    const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.15,
                children: [

                  QuickActionCard(
                    title: "Services",
                    icon: Icons.content_cut,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ServiceListScreen(),
                        ),
                      );
                    },
                  ),

                  QuickActionCard(
                    title: "My Bookings",
                    icon: Icons.calendar_month,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const MyBookingsScreen(),
                        ),
                      );
                    },
                  ),

                  QuickActionCard(
                    title: "Membership",
                    icon: Icons.workspace_premium,
                    onTap: () {},
                  ),

                  QuickActionCard(
                    title: "Offers",
                    icon: Icons.local_offer,
                    onTap: () {},
                  ),
                ],
              ),

              AppSpacing.h32,

              const SectionHeader(
                title: "Today's Offer",
              ),

              AppSpacing.h12,

              PremiumCard(
                gradient: AppColors.primaryGradient,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      "20% OFF",
                      style: AppTextStyles.headlineMedium
                          .copyWith(
                        color: Colors.black,
                      ),
                    ),

                    AppSpacing.h8,

                    Text(
                      "Hair Spa Package",
                      style: AppTextStyles.titleLarge
                          .copyWith(
                        color: Colors.black,
                      ),
                    ),

                    AppSpacing.h8,

                    Text(
                      "Limited time offer.\nBook today and save on your premium hair spa experience.",
                      style: AppTextStyles.bodyMedium
                          .copyWith(
                        color: Colors.black87,
                      ),
                    ),

                  ],
                ),
              ),

              AppSpacing.h32,

              const SectionHeader(
                title: "Recent Notification",
              ),

              AppSpacing.h12,

              PremiumCard(
                child: Row(
                  children: [

                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary
                            .withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: AppColors.primary,
                      ),
                    ),

                    AppSpacing.w16,

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Welcome to Hair Art Salon",
                            style:
                                AppTextStyles.titleMedium,
                          ),

                          AppSpacing.h4,

                          Text(
                            "Book your first appointment and enjoy our premium services.",
                            style:
                                AppTextStyles.bodySmall,
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),

              AppSpacing.h32,
            ],
          ),
        ),
      ),
    );
  }
}
