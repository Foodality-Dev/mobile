import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_service.dart';
import '../models/user.dart';
import '../nav.dart';
import '../widgets/text_button.dart';
import '../widgets/text_form_field.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final ApiService api = ApiService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  String? _emailErrorMsg;
  String? _passwordErrorMsg;

  Future<void> attemptSignIn() async {
    try {
      setState(() {
        _emailErrorMsg = null;
        _passwordErrorMsg = null;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      UserModel user = await api.getUser(FirebaseAuth.instance.currentUser?.uid);
      Map<String, dynamic> userJson = user.toJson();

      final prefs = await SharedPreferences.getInstance();
      setState(() {
        final String userString = jsonEncode(userJson);
        prefs.setString('user', userString);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        setState(() {
          _emailErrorMsg = "Email not found or incorrect password";
          _passwordErrorMsg = "Email not found or incorrect password";
        });
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        setState(() {
          _emailErrorMsg = "Email not found or incorrect password";
          _passwordErrorMsg = "Email not found or incorrect password";
        });
      } else {
        log('FirebaseAuthException for login');
      }
    }

  }

  

  @override
  Widget build(BuildContext context) {
    // bool _signingIn = false;

    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // EYE ICON CLICK CAUSES THIS TO APPEAR AND IT'S WEIRD. 
        // if (snapshot.connectionState != ConnectionState.active) {
        //   return Center(child: CircularProgressIndicator());
        // }
        final user = snapshot.data;
        if (user != null) {
          log("user is logged in! this is from login.dart");
          // api.addUsernameCollection();
          return const Nav();
        }
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 30,
            centerTitle: true,
            // title: Image.asset('assets/logos/questify_1152.png',
            //     width: 40, height: 40, fit: BoxFit.fitHeight)),
          ),
          body: SingleChildScrollView(
            child: Form(key: _formKey, child: Column(children: [
              Image.asset('assets/stars_login.png', color: const Color(0xFF7FD7FF), width: MediaQuery.of(context).size.width),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                child: Column(children: [
                  Text(
                    "welcome back, explorer",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontSize: 36)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: QFEmailFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      hintText: 'email address',
                      errorText: _emailErrorMsg,
                    ),
                  ),
                  QFPasswordFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    hintText: 'password',
                    errorText: _passwordErrorMsg,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          attemptSignIn();
                        }
                      },
                      style: QFButtonStyle.medium(),
                      child: Text(
                        "sign in",
                        style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(color: Colors.black)
                      )
                    ),
                  ),
                ])
              )
            ]))
          )
        );
      }
    );
  }
}