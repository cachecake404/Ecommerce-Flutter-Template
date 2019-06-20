import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//Tempelate for Auth

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}

// Class with methods for authenthication with firebase.
class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    String message = "";
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      message = e.message;
    });
    return message;
  }

  Future<String> signUp(String email, String password) async {
    String message = "";
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      message = e.message;
    });

    return message;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
