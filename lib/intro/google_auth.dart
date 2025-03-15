
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/api_service.dart';


class Authentication {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

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

      String? userEmail = user?.email;

      // Optional: Save user data
      // UserModel userMod = await api.getUser(user?.uid);
      // Map<String, dynamic> userJson = userMod.toJson();
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString('user', jsonEncode(userJson));

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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );

    } catch (e) {
      if (!context.mounted) return null; // Prevent crashes

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred using Google Sign-In. Please try again.')),
      );
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
        // String? userEmail = user?.email;
        // print("sign up?");
        // print(userEmail);

        //

        // UserModel? userMod = await api.getUser(FirebaseAuth.instance.currentUser?.uid);

        // Map<String, dynamic> userJson = userMod.toJson();
        
        // final prefs = await SharedPreferences.getInstance();
        
        // final String userString = jsonEncode(userJson);
        // prefs.setString('user', userString);
      

        
      } on FirebaseAuthException catch (e) {
        // Removing this first if-statement for security reasons, we do not want
        // people to know the account exists w/ diff credenials
        // if (e.code == 'Account already exists') {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     Authentication.customSnackBar(
        //       content:
        //           'The account already exists.',
        //     ),
        //   );
        if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content:
                  'An error occurred while logging in. Please try again.',
            ),
          );
        }
      } catch (e) {
      
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'An error occurred using Google Sign-In. Please try again.',
          ),
        );
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
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }
}