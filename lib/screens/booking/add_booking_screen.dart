import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/booking.dart';
import '../../providers/booking_provider.dart';
import '../../core/constants/booking_status.dart';

class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({super.key});

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _notesController = TextEditingController();

  String _service = "Hair Cut";
  double _price = 200;

  DateTime _date = DateTime.now();

  TimeOfDay _time = TimeOfDay.now();

  final Map<String, double> services = {
    "Hair Cut": 200,
    "Beard Trim": 100,
    "Hair Spa": 800,
    "Hair Color": 1200,
    "Facial": 600,
  };

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

              DropdownButtonFormField<String>(
                value: _service,
                decoration: const InputDecoration(
                  labelText: "Service",
                ),
                items: services.keys.map((service) {
                  return DropdownMenuItem(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _service = value!;
                    _price = services[value]!;
                  });
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
                    serviceId: _service,
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

                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text("BOOK NOW"),
              )
            ],
          ),
        ),
      ),
    );
  }
}