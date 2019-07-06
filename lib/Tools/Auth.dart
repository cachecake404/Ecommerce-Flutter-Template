import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:flutter_facebook_login/flutter_facebook_login.dart";
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
      await _firebaseAuth.signInWithCredential(creds);
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
        print("LOGGED IN");
        final AuthCredential creds = FacebookAuthProvider.getCredential(
            accessToken: fbResult.accessToken.token);
        await _firebaseAuth.signInWithCredential(creds);
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
