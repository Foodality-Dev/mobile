import 'dart:convert';
// import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_service.dart';
import '../models/user.dart';
import '../nav.dart';
import '../widgets/text_button.dart';
import 'login.dart';


class Congrats extends StatefulWidget {
  const Congrats({
    super.key,
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.avatarImagePath,
    required this.interests,
  });

  final String? email;
  final String? password;
  final String username;
  final String firstName;
  final String lastName;
  final String avatarImagePath;
  final List<String> interests;

  @override
  State<Congrats> createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  Future<void> signUp(
    String? email,
    String? password,
    String username,
    String firstName,
    String lastName,
    String avatarImagePath,
    List<String> interests
  ) async {
    // print("##### ${userCred.user}");
    // userCred.user!.sendEmailVerification();  // TODO use actioncodesettings??

    // userCred.user!.reload();  // TODO ui bound or app bound??
    // userCred.user!.emailVerified;

    // TODO: finish email verification
    // FirebaseAuth.instance.applyActionCode("code")
    //     .then((value) {
    // })
    //     .onError((error, stackTrace) {
    // });

    String avatarUrl = "";
    if (avatarImagePath != "") avatarUrl = await uploadImage(File(avatarImagePath), FirebaseAuth.instance.currentUser!.uid);
    print(FirebaseAuth.instance.currentUser); 
    final user = UserModel(
        id: FirebaseAuth.instance.currentUser?.uid,
        geoId: "UCI", // hardcoded right now
        createdAt: Timestamp.now(),
        username: username,
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatarUrl,
        bio: 'bio..', // hardcoded right now
        rank: 'Comet', // hardcoded right now
        xp: 0, // hardcoded right now
        interests: interests,
        major: 'CS', // hardcoded right now
        gradYear: 2025 // hardcoded right now
    );

    ApiService().addUser(user);
    final prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> userJson = user.toJson();
    final String _userString = jsonEncode(userJson);
    await prefs.setString('user', _userString);
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.userChanges(),
    //   initialData: FirebaseAuth.instance.currentUser,
    //   builder: (context, snapshot) {
    //     // EYE ICON CLICK CAUSES THIS TO APPEAR AND IT'S WEIRD. 
    //     // if (snapshot.connectionState != ConnectionState.active) {
    //     //   return Center(child: CircularProgressIndicator());
    //     // }
    //     final user = snapshot.data;
    //     if (user != null) {
    //       log("user is logged in! this is from congrats.dart");
    //       return const Nav();
    //     }
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 30,
            title: Align(alignment: Alignment.centerRight, child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login())
                );
              },
              child: Text(
                textAlign: TextAlign.center,
                "sign in",
                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: Colors.white.withOpacity(0.75)),
              ),
            )
          )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 45, bottom: 15),
                child: Center(child: Image.asset('assets/congrats.png', height: MediaQuery.of(context).size.height / 3))
              ),
              Text('success!', style: Theme.of(context).primaryTextTheme.titleLarge),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text('welcome to questify', style: Theme.of(context).primaryTextTheme.titleLarge),
              ),
              Text('your all-in-one university app', style: Theme.of(context).primaryTextTheme.titleSmall!.copyWith(color: Colors.white.withOpacity(0.75))),
              Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(padding: const EdgeInsets.only(bottom: 45.0), child: TextButton(
                      onPressed: () async {
                        signUp(
                          widget.email,
                          widget.email,
                          widget.username,
                          widget.firstName,
                          widget.lastName,
                          widget.avatarImagePath,
                          widget.interests
                        );
                        for(int i = 0; i <= 4; ++i) {
                          Navigator.pop(context);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Nav())
                        );
                      },
                      style: QFButtonStyle.medium(),
                      child: Text(
                        "visit your space", 
                        style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(color: Colors.black)
                      )
                    )),
                  ),
                ),
            ]),
          )
        );
    //   }
    // );
  }
}