import 'package:flutter/material.dart';

import '../models/service.dart';
import '../repositories/service_repository.dart';

class ServiceProvider extends ChangeNotifier {
  final ServiceRepository _repository = ServiceRepository();

  List<ServiceModel> services = [];

  void loadServices() {
    _repository.getServices().listen((data) {
      services = data;
      notifyListeners();
    });
  }

  Future<void> addService(ServiceModel service) async {
    await _repository.addService(service);
  }

  Future<void> updateService(ServiceModel service) async {
    await _repository.updateService(service);
  }

  Future<void> deleteService(String id) async {
    await _repository.deleteService(id);
  }
}