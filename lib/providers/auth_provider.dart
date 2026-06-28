import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserRepository _userRepository = UserRepository();

  User? user;
  bool isLoading = false;

  Future<void> signIn() async {
    isLoading = true;
    notifyListeners();

    user = await _authService.signInWithGoogle();

    if (user != null) {
      final userModel = UserModel(
        uid: user!.uid,
        name: user!.displayName ?? '',
        email: user!.email ?? '',
        photoUrl: user!.photoURL,
        createdAt: DateTime.now(),
      );

      print("Saving user to Firestore...");
      await _userRepository.saveUser(userModel);
      print("User saved.");
    }

    isLoading = false;
    notifyListeners();
  }
}