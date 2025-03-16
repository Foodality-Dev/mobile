import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Authentication {
  static Future<User?> signUpWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ["email"]
    );

    try {
      // Trigger Google Sign-In
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        // User canceled login, return null
        return null;
      }

      // Get authentication details from Google
      final GoogleSignInAuthentication googleSignInAuthentication = 
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await auth.signInWithCredential(credential);
      user = userCredential.user;

    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return null; // Prevent crashes

      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'account-exists-with-different-credential') {
        errorMessage = 'This email is already linked to another sign-in method.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use. Try another one.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Invalid credentials. Please try again.';
      }

      print("error... #signUpWithGoogle: $errorMessage");

    } catch (e) {
      if (!context.mounted) return null; // Prevent crashes
    }

    return user;
  }


  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    // ApiService api = ApiService();

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);

        user = userCredential.user;
      } catch (e) {
        print("error... #signInWithGoogle");
      }
    }

    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // if (!kIsWeb) {
      // We are not using web so do not need to check for web
      await googleSignIn.signOut();
      // }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("error... #signOut");
    }
  }
}