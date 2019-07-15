import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:flutter_facebook_login/flutter_facebook_login.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
//Tempelate for Auth

// abstract class BaseAuth {
//   Future<String> signIn(String email, String password);
//   Future<String> signUp(String email, String password);
//   Future<FirebaseUser> getCurrentUser();
//   Future<void> signOut();
// }

// Class with methods for authenthication with firebase.
class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithGoogle() async {
    String message = "";
    try {
      GoogleSignIn googleSignInObj = new GoogleSignIn();
      GoogleSignInAccount googleAcc = await googleSignInObj.signIn();
      GoogleSignInAuthentication googleAuth = await googleAcc.authentication;
      final AuthCredential creds = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      FirebaseUser user = await _firebaseAuth.signInWithCredential(creds);
      setFireData(user);
    } catch (e) {
      message = e.toString();
    }
    return message;
  }

  Future<String> signInWithFacebook() async {
    String message = "failed";
    try {
      FacebookLogin facebookSignInObj = new FacebookLogin();
      FacebookLoginResult fbResult =
          await facebookSignInObj.logInWithReadPermissions(["email"]);
      if (fbResult.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential creds = FacebookAuthProvider.getCredential(
            accessToken: fbResult.accessToken.token);
        FirebaseUser user = await _firebaseAuth.signInWithCredential(creds);
        setFireData(user);
        message = "";
      } else {
        print(fbResult.errorMessage);
        return "Failed with facebook status: " + fbResult.status.toString();
      }
    } catch (e) {
      message = e.toString();
    }
    return message;
  }

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
    FirebaseUser user = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      message = e.message;
    });
    setFireData(user);

    return message;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String> resetPassword(String email) async {
    String message = "";
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      message = e.toString();
    }
    return message;
  }

  void setFireData(FirebaseUser user) async {
    DocumentSnapshot dataShot =
        await Firestore.instance.collection("cards").document(user.uid).get();
    if (dataShot.data == null) {
      Firestore.instance
          .collection("cards")
          .document(user.uid)
          .setData({"custId": "new", "email": user.email});
    }
  }
}
