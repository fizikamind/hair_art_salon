import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/booking.dart';
import '../../providers/booking_provider.dart';
import '../../core/constants/booking_status.dart';

import '../../models/notification_model.dart';
import '../../providers/notification_provider.dart';
import '../../providers/service_provider.dart';


class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({super.key});

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _notesController = TextEditingController();

  String? _selectedServiceId;

  String _service = "";
  double _price = 0;

  DateTime _date = DateTime.now();

  TimeOfDay _time = TimeOfDay.now();


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
        title: const Text("Book Appointment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [


              Consumer<ServiceProvider>(
                builder: (context, provider, child) {
                  final services = provider.services
                      .where((service) => service.isActive)
                      .toList();

                  if (services.isEmpty) {
                    return const Center(
                      child: Text("No Services Available"),
                    );
                  }

                  if (_selectedServiceId == null) {
                    _selectedServiceId = services.first.id;
                    _service = services.first.name;
                    _price = services.first.price;
                  }

                  return DropdownButtonFormField<String>(
                    value: _selectedServiceId,
                    decoration: const InputDecoration(
                      labelText: "Service",
                    ),
                    items: services.map((service) {
                      return DropdownMenuItem<String>(
                        value: service.id,
                        child: Text(
                          "${service.name} - ₹${service.price.toStringAsFixed(0)}",
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      final selected =
                      services.firstWhere((e) => e.id == value);

                      setState(() {
                        _selectedServiceId = selected.id;
                        _service = selected.name;
                        _price = selected.price;
                      });
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              ListTile(
                title: Text(
                  "Date : ${_date.day}/${_date.month}/${_date.year}",
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2035),
                  );

                  if (picked != null) {
                    setState(() {
                      _date = picked;
                    });
                  }
                },
              ),

              ListTile(
                title: Text(
                  "Time : ${_time.format(context)}",
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _time,
                  );

                  if (picked != null) {
                    setState(() {
                      _time = picked;
                    });
                  }
                },
              ),

              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Notes",
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async {

                  final firebaseUser =
                      FirebaseAuth.instance.currentUser;

                  if (firebaseUser == null) return;

                  final booking = Booking(
                    customerId: firebaseUser.uid,
                    customerName:
                    firebaseUser.displayName ?? "",
                    serviceId: _selectedServiceId ?? "",
                    serviceName: _service,
                    bookingDate: _date,
                    bookingTime: _time.format(context),
                    price: _price,
                    status: BookingStatus.pending,
                    notes: _notesController.text,
                    createdAt: DateTime.now(),
                  );

                  await Provider.of<BookingProvider>(
                    context,
                    listen: false,
                  ).addBooking(booking);

                  // Create notification
                  final notification = NotificationModel(
                    id: '',
                    userId: firebaseUser.uid,
                    title: 'Booking Received',
                    message:
                    'Your booking request has been received. We will confirm it shortly.',
                    type: 'booking',
                    bookingId: null,
                    isRead: false,
                    createdAt: DateTime.now(),
                  );

                  await Provider.of<NotificationProvider>(
                    context,
                    listen: false,
                  ).addNotification(notification);

                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text("BOOK APPOINTMENT"),
              )
            ],
          ),
        ),
      ),
    );
  }
}