import '../models/user_model.dart';
import '../services/firestore_service.dart';

class UserRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> saveUser(UserModel user) async {
    await _firestoreService.saveUser(user);
  }

  Future<UserModel?> getUser(String uid) async {
    return await _firestoreService.getUser(uid);
  }

  Future<void> updateUser(UserModel user) async {
    await _firestoreService.updateUser(user);
  }
}