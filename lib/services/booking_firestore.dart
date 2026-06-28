import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/constants/booking_status.dart';
import '../models/booking.dart';

class BookingFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _collection = 'bookings';

  /// Add Booking
  Future<void> addBooking(Booking booking) async {
    await _firestore.collection(_collection).add(
      booking.toMap(),
    );
  }

  /// All Bookings (Admin)
  Stream<List<Booking>> getBookings() {
    return _firestore
        .collection(_collection)
        .orderBy('bookingDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Booking.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }

  /// Current Bookings (Customer)
  Stream<List<Booking>> getCurrentBookings(String customerUid) {
    return _firestore
        .collection(_collection)
        .where('customerId', isEqualTo: customerUid)
        .orderBy('bookingDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Booking.fromMap(doc.id, doc.data()))
          .where(
            (booking) =>
        booking.status == BookingStatus.pending ||
            booking.status == BookingStatus.confirmed ||
            booking.status == BookingStatus.inProgress,
      )
          .toList();
    });
  }

  /// Booking History (Customer)
  Stream<List<Booking>> getBookingHistory(String customerUid) {
    return _firestore
        .collection(_collection)
        .where('customerId', isEqualTo: customerUid)
        .orderBy('bookingDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Booking.fromMap(doc.id, doc.data()))
          .where(
            (booking) =>
        booking.status == BookingStatus.completed ||
            booking.status == BookingStatus.cancelled,
      )
          .toList();
    });
  }

  /// Update Booking
  Future<void> updateBooking(Booking booking) async {
    await _firestore
        .collection(_collection)
        .doc(booking.id)
        .update(
      booking.toMap(),
    );
  }

  /// Delete Booking
  Future<void> deleteBooking(String id) async {
    await _firestore
        .collection(_collection)
        .doc(id)
        .delete();
  }
}