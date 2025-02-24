/**
 * NOTE: AS OF 9/14, THE SIGN UP WIDGET IS NO LONGER IN USE, BUT HAS BEEN KEPT FOR FUTURE
 * DEVELOPMENT PURPOSES -- Aditya Phatak
 */
// import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../api/api_service.dart';
// import '../nav.dart';
// import '../widgets/text_button.dart';
// import '../widgets/text_form_field.dart';
import 'create_profile.dart';
import 'google_auth.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  bool passwordVisible = false;
  bool confPasswordVisible = false;
  String? emailErrorText;

  final ApiService apiService = ApiService();
  bool isCheckedTermsAndService = false;

  // Future<void> _showEmailExistsAlert() {
  //   print("email exists so printing alert!");
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         contentPadding: const EdgeInsets.all(4.0),
  //         insetPadding: const EdgeInsets.all(4.0),
  //         buttonPadding: const EdgeInsets.all(0.0),
  //         title: const Text(
  //           "Error",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             color: Colors.black,
  //           ),
  //         ),
  //         content: const Text(
  //           "Email already exists.",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             color: Colors.black,
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
    //       log("user is logged in! this is from signup.dart");
    //       print('got logged??');
    //       return const Nav();
    //     }
        
        return Scaffold(
          // resizeToAvoidBottomInset: false,
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
              Image.asset('assets/stars_signup.png', color: const Color(0xFF7FD7FF), width: MediaQuery.of(context).size.width),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  children: [
                    Text(
                      "start your journey, now",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontSize: 36)
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 45.0, bottom: 20.0),
                    //   child: QFEmailFormField(
                    //     controller: emailController,
                    //     textInputAction: TextInputAction.next,
                    //     hintText: 'email address',
                    //     errorText: emailErrorText,
                    //   ),
                    // ),
                    // QFPasswordFormField(
                    //   firstTime: true,
                    //   controller: passwordController,
                    //   textInputAction: TextInputAction.next,
                    //   hintText: 'password',
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20, bottom: 20),
                    //   child: QFPasswordFormField(
                    //     controller: confPasswordController,
                    //     textInputAction: TextInputAction.done,
                    //     hintText: 'confirm your password',
                    //     actualPasswordController: passwordController,
                    //   ),
                    // ),
                    TextButton(
                        onPressed: () async {
                          User? user = await Authentication.signUpWithGoogle(context: context);
                          
                          // if (context.mounted) {
                          //   Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //       builder: (context) => CreateProfile(email: user?.email, password: user?.email)
                          //     ),
                          //   );
                          // }
                      
                          // }

                          apiService
                          .isEmailRegistered(user?.email)
                          .then((registered) {
                            if(registered) {
                              setState(() {
                                emailErrorText = "Email already exists";
                              });
                              // _showEmailExistsAlert();
                            } else {
                              print('going to createProfile');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return CreateProfile(
                                      email: user?.email, // email Controller.text.toLowerCase().trim(),
                                      password: user?.email // passwordController.text,
                                    );
                                  })
                              );
                            }
                          });

                          setState(() {
                            // _signingIn = false;
                          });

                    
                        },
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          // backgroundColor: const Color(0xFF7FD7FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: const Color(0xFFD9D9D9).withOpacity(0.2), width: 1)
                          )
                        ),
                        child: Padding(padding: EdgeInsets.only(left: 5), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Padding(padding: EdgeInsets.only(right: 10), child: ImageIcon(AssetImage('assets/icons/google.png'), color: Colors.white)),
                          Text('UCI NetID', style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(color: Colors.white.withOpacity(0.75)))
                        ])),   
                    ), 
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).primaryTextTheme.labelSmall,
                          children: <TextSpan>[
                            const TextSpan(text: 'By clicking "create account" I agree to the '),
                            TextSpan(
                              text: 'Questify Terms',
                              style: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Questify Terms');
                              }
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Privacy Policy');
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Padding(padding: const EdgeInsets.symmetric(vertical: 15.0), child: TextButton(
                    //   onPressed: () async {
                    //     setState(() {
                    //       emailErrorText = null;
                    //     });
                    //     // signUp();
                    //     // Validate returns true if the form is valid, or false otherwise.
                    //     if (_formKey.currentState!.validate()) {
                    //       // If the form is valid, display a snackbar. In the real world,
                    //       // you'd often call a server or save the information in a database.

                    //       apiService
                    //           .isEmailRegistered(emailController.text.toLowerCase().trim())
                    //           .then((registered) {
                    //             if(registered) {
                    //               setState(() {
                    //                 emailErrorText = "Email already exists";
                    //               });
                    //               // _showEmailExistsAlert();
                    //             } else {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(builder: (context) {
                    //                     return CreateProfile(
                    //                       email: emailController.text.toLowerCase().trim(),
                    //                       password: passwordController.text,
                    //                     );
                    //                   })
                    //               );
                    //             }
                    //           });
                    //     }
                    //   },
                    //   style: QFButtonStyle.medium(),
                    //   child: Text(
                    //     "create account", 
                    //     style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(color: Colors.black)
                    //   ),
                    // )),
                  ]
                )
              ),
            ])),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,       
              children: [
                Text(
                  "Already have an account?",
                  style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: Colors.white.withOpacity(0.75)),
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                  onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login())
                    )
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    "Log in",
                    style: Theme.of(context).primaryTextTheme.bodyMedium,
                  ),
                )
              ]
            )
          ),
        );
      }
    // );
  // }
}