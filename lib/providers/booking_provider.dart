import 'package:flutter/material.dart';

import '../models/booking.dart';
import '../repositories/booking_repository.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();

  List<Booking> bookings = [];
  List<Booking> currentBookings = [];

  List<Booking> bookingHistory = [];

  /// Load bookings from Firestore
  void loadBookings() {
    _repository.getBookings().listen((data) {
      bookings = data;
      notifyListeners();
    });
  }
  /// Load current bookings
  void loadCurrentBookings(String uid) {
    _repository.getCurrentBookings(uid).listen((data) {
      currentBookings = data;
      notifyListeners();
    });
  }

  /// Load booking history
  void loadBookingHistory(String uid) {
    _repository.getBookingHistory(uid).listen((data) {
      bookingHistory = data;
      notifyListeners();
    });
  }
  /// Add booking
  Future<void> addBooking(Booking booking) async {
    await _repository.addBooking(booking);
  }

  /// Update booking
  Future<void> updateBooking(Booking booking) async {
    await _repository.updateBooking(booking);
  }

  /// Delete booking
  Future<void> deleteBooking(String id) async {
    await _repository.deleteBooking(id);
  }
}