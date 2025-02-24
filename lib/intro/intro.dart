import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../nav.dart';
import '../widgets/text_button.dart';
import 'create_profile.dart';
import 'google_auth.dart';
import 'login.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final ApiService apiService = ApiService();

  Future<void> _showEmailsAlert(String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(4.0),
          insetPadding: const EdgeInsets.all(4.0),
          buttonPadding: const EdgeInsets.all(0.0),
          title: const Text(
            "Error",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 30,
        // for the below line: https://stackoverflow.com/questions/44978216/flutter-remove-back-button-on-appbar
        automaticallyImplyLeading: false,
        // title: Image.asset('assets/logos/questify_1152.png',
        //     width: 40, height: 40, fit: BoxFit.fitHeight)),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset('assets/intro_stars.png', width: deviceSize.width * .75),
          Image.asset('assets/logos/AndroidQ.png',width: deviceSize.width * .75),
          //Image.asset('assets/logos/questify_logo_intro.png',width: deviceSize.width * .75),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.14,
                  right: MediaQuery.of(context).size.width * 0.14,
                  // bottom: 30
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Questify",
                        style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontSize: 45),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: deviceSize.height * .059, left: deviceSize.width * .115, right: deviceSize.width * .115), child: TextButton(
                      onPressed: () async {
                        User? user = await Authentication.signInWithGoogle(context: context);
                      
                        // check usernames collection and see if any username has
                        // a userId of FirebaseAuth.instance.currentUser.uid                          
                        if(await apiService.getUserIdCount(FirebaseAuth.instance.currentUser!.uid) <= 0) {
                        // if user does not exist, then:
                          if(context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return CreateProfile(
                                    email: user?.email,
                                    password: user?.email
                                  );
                                })
                            );
                          }
                        }
                        else {
                          if (context.mounted){
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Nav()
                              ),
                            );
                          }
                        }
                      },
                      style: QFButtonStyle.medium(backgroundColor: const Color(0xFF7FD7FF)),
                      child: Text(
                        "UCI NetID",
                        style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(color: const Color(0xFF181A1E))
                      ),
                    )),
                  ]
                )
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(deviceSize.width * 0.63, deviceSize.height * 0.06, 0, 0),
            child: Image.asset('assets/icons/stats_selected.png', width: deviceSize.width * 0.13),
          ),
          Center(
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const Login();
                })
              ),
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "admin login", 
                style: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(color: const Color(0xFF7FD7FF))
              ) 
            ),
          )
        ]),
      ),
    );
  }
}