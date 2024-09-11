import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_provider/models/user_model.dart';
import 'package:shopping_provider/utils/results.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _auth.authStateChanges().map((user) {
      return UserModel(email: user?.email ?? "");
    });
  }

  final StreamController<Results> _resultsLogin =
  StreamController<Results>.broadcast();

  Stream<Results> get resultsLogin => _resultsLogin.stream;

  final StreamController<Results> _resultsRegister =
  StreamController<Results>.broadcast();

  Stream<Results> get resultsRegister => _resultsRegister.stream;

  Future<void> signIn(String email, String password) async {
    _resultsLogin.add(LoadingResult());

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _resultsLogin.add(SuccessResult());
    } on FirebaseAuthException catch (e, stackTrace) {
      _resultsLogin.add(ErrorResult(code: e.code));
      debugPrint('FirebaseAuthException during sign in: $e\n$stackTrace');
    } catch (e, stackTrace) {
      _resultsLogin.add(ErrorResult(code: 'unknown'));
      debugPrint('Unknown error during sign in: $e\n$stackTrace');
    }
  }

  Future<void> register(String email, String password, String name) async {
    _resultsRegister.add(LoadingResult());

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);

      _resultsRegister.add(SuccessResult());
    } on FirebaseAuthException catch (e, stackTrace) {
      String errorCode = e.code;
      if (errorCode == 'weak-password') {
        _resultsRegister.add(ErrorResult(code: 'A senha é muito fraca.'));
      } else if (errorCode == 'email-already-in-use') {
        _resultsRegister.add(ErrorResult(code: 'O email já está em uso.'));
      } else {
        _resultsRegister.add(ErrorResult(code: e.code));
      }
      debugPrint('FirebaseAuthException during registration: $e\n$stackTrace');
    } catch (e, stackTrace) {
      _resultsRegister.add(ErrorResult(code: 'unknown'));
      debugPrint('Unknown error during registration: $e\n$stackTrace');
    }
  }

  Future<String?> getUserEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user?.email;
    } catch (e) {
      print("Error getting user email: $e");
      return null;
    }
  }

  Future<String?> getUserName() async {
    User? user = _auth.currentUser;
    return user?.displayName;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  void dispose() {
    _resultsLogin.close();
    _resultsRegister.close();
  }
}
