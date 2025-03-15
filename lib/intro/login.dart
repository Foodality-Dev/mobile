import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/intro/google_auth.dart';
import 'package:mobile/nav.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user != null) {
          print("User is logged in via Google!");
          return const Nav();
        }

        return Scaffold(
          body: Stack(
            children: [
              // 🔥 Background Image
              Positioned.fill(
                child: Image.asset(
                  "assets/splash_screen/background.png", // Change to your image path
                  fit: BoxFit.cover, // Covers the full screen
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // App Title (Looks Crisp)
                    Image.asset("assets/logos/foodality_full_logo.png", height: 150),
                    const SizedBox(height: 30),
              
                    // Google Sign-In Button
                    _buildSocialButton( // https://developers.google.com/identity/branding-guidelines
                      icon: "assets/icons/passwordless/google-icon.png",
                      text: "Continue with Google",
                      onPressed: () async {
                        await Authentication.signInWithGoogle(context: context);
                      }
                    ),
                    const SizedBox(height: 12),
              
                    // Facebook Sign-In Button
                    // _buildSocialButton(
                    //   icon: "assets/icons/passwordless/facebook-icon.png",
                    //   text: "Continue with Facebook",
                    //   onPressed: () => print("Facebook Sign-In Pressed"),
                    // ),
                    // const SizedBox(height: 12),
              
                    // Apple Sign-In Button
                    _buildSocialButton(
                      icon: "assets/icons/passwordless/apple-icon.png",
                      text: "Continue with Apple",
                      onPressed: () => print("Apple Sign-In Pressed"), // TODO: APPLE SIGNIN
                    ),
                    const SizedBox(height: 12),
              
                    // Terms & Privacy
                    const Text(
                      "By continuing, you agree to our",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => print("Terms of Service Pressed"), // TODO LINK TO TOS
                          child: const Text(
                            "Terms of Service",
                            style: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Text(" and ", style: TextStyle(fontSize: 12, color: Colors.black54)),
                        GestureDetector(
                          onTap: () => print("Privacy Policy Pressed"), // TODO LINK TO PRIVACY POLICY
                          child: const Text(
                            "Privacy Policy",
                            style: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]
          ),
        );
      }
    );
  }

  // 🔥 Social Button Widget
  Widget _buildSocialButton({required String icon, required String text, required VoidCallback onPressed}) {
    return OutlinedButton( 
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: const BorderSide(color: Colors.black),
        backgroundColor: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, height: 24), // Social media icon
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
