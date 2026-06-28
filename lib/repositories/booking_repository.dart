
import '../models/booking.dart';
import '../services/booking_firestore.dart';

class BookingRepository {
  final BookingFirestore _bookingFirestore = BookingFirestore();

  Future<void> addBooking(Booking booking) async {
    await _bookingFirestore.addBooking(booking);
  }

  Stream<List<Booking>> getBookings() {
    return _bookingFirestore.getBookings();
  }

  Future<void> updateBooking(Booking booking) async {
    await _bookingFirestore.updateBooking(booking);
  }

  Future<void> deleteBooking(String id) async {
    await _bookingFirestore.deleteBooking(id);
  }
  Stream<List<Booking>> getCurrentBookings(String uid) {
    return _bookingFirestore.getCurrentBookings(uid);
  }

  Stream<List<Booking>> getBookingHistory(String uid) {
    return _bookingFirestore.getBookingHistory(uid);
  }

}

