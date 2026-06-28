import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/service.dart';
import '../../providers/service_provider.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ServiceProvider>(
        context,
        listen: false,
      ).loadServices();
    });
  }

  IconData _getIcon(String category) {
    switch (category.toLowerCase()) {
      case "hair":
        return Icons.content_cut;

      case "beard":
        return Icons.face;

      case "facial":
        return Icons.spa;

      case "spa":
        return Icons.air;

      case "color":
      case "hair color":
        return Icons.palette;

      default:
        return Icons.content_cut;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services"),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, provider, child) {
          final activeServices = provider.services
              .where((service) => service.isActive)
              .toList();

          if (activeServices.isEmpty) {
            return const Center(
              child: Text(
                "No Services Available",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: activeServices.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final ServiceModel service = activeServices[index];

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),

                  leading: CircleAvatar(
                    radius: 28,
                    child: Icon(
                      _getIcon(service.category),
                      size: 28,
                    ),
                  ),

                  title: Text(
                    service.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          service.category,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "${service.duration} Minutes",
                        ),

                        if (service.description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              service.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),

                  trailing: Text(
                    "₹${service.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}