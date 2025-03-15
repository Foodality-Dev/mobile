import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/intro/google_auth.dart';
import 'package:mobile/intro/login.dart';
import 'package:mobile/nav.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user != null) {
          print("User is logged in via Google!");
          return TextButton(onPressed: () async => await Authentication.signOut(context: context), child: Text("signout"));
        }
        return Login();
      }
    );
  }
}