import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/service_provider.dart';
import '../../models/service.dart';
import '../services/add_service_screen.dart';
import '../services/edit_service_screen.dart';


class AdminServiceScreen extends StatefulWidget {
  const AdminServiceScreen({super.key});

  @override
  State<AdminServiceScreen> createState() => _AdminServiceScreenState();
}

class _AdminServiceScreenState extends State<AdminServiceScreen> {

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Services"),
      ),

      body: Consumer<ServiceProvider>(
        builder: (context, provider, child) {

          if (provider.services.isEmpty) {
            return const Center(
              child: Text("No Services Found"),
            );
          }

          return ListView.builder(
            itemCount: provider.services.length,
            itemBuilder: (context, index) {

              ServiceModel service =
              provider.services[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                child: ListTile(

                  title: Text(
                    service.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    "₹${service.price}\n"
                        "${service.duration} Minutes",
                  ),

                  trailing: PopupMenuButton<String>(

                    onSelected: (value) async {

                      if (value == "edit") {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                EditServiceScreen(
                                  service: service,
                                ),
                          ),
                        );

                      } else if (value == "delete") {

                        bool? confirm =
                        await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(

                            title: const Text(
                              "Delete Service",
                            ),

                            content: const Text(
                              "Are you sure?",
                            ),

                            actions: [

                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    false,
                                  );
                                },
                                child: const Text("Cancel"),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    true,
                                  );
                                },
                                child: const Text("Delete"),
                              ),

                            ],
                          ),
                        );

                        if (confirm == true) {

                          await provider.deleteService(
                            service.id,
                          );
                        }
                      }
                    },

                    itemBuilder: (context) => [

                      const PopupMenuItem(
                        value: "edit",
                        child: Text("Edit"),
                      ),

                      const PopupMenuItem(
                        value: "delete",
                        child: Text("Delete"),
                      ),

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddServiceScreen(),
            ),
          );

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}