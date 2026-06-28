import '../models/service.dart';
import '../services/service_firestore.dart';

class ServiceRepository {
  final ServiceFirestore _firestore = ServiceFirestore();

  Future<void> addService(ServiceModel service) async {
    await _firestore.addService(service);
  }

  Future<void> updateService(ServiceModel service) async {
    await _firestore.updateService(service);
  }

  Future<void> deleteService(String id) async {
    await _firestore.deleteService(id);
  }

  Stream<List<ServiceModel>> getServices() {
    return _firestore.getServices();
  }
}