import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/service.dart';

class ServiceFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference services =
  FirebaseFirestore.instance.collection('services');

  /// Add Service
  Future<void> addService(ServiceModel service) async {
    await services.add(service.toMap());
  }

  /// Get All Services
  Stream<List<ServiceModel>> getServices() {
    return services.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceModel.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }

  /// Update Service
  Future<void> updateService(ServiceModel service) async {
    await services
        .doc(service.id)
        .update(service.toMap());
  }

  /// Delete Service
  Future<void> deleteService(String id) async {
    await services
        .doc(id)
        .delete();
  }
}