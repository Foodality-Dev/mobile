import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_name.dart';
import 'signup_controller.dart';

class SignupEmailPassword extends StatefulWidget {
  const SignupEmailPassword({super.key});

  @override
  State<SignupEmailPassword> createState() => _SignupEmailPasswordState();
}

class _SignupEmailPasswordState extends State<SignupEmailPassword> {
  final _formKey = GlobalKey<FormState>();
  final SignupData signupData = SignupData();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final auth = FirebaseAuth.instance;

  String? error;
  bool isLoading = false;

  final Color primaryRed = const Color(0xFFC50102);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌅 Background image
          Positioned.fill(
            child: Image.asset(
              "assets/splash_screen/background.png", // update path if needed
              fit: BoxFit.cover,
            ),
          ),
          // 💻 UI Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🧱 Header
                  const Text(
                    "Let's get you started",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter your email and password to create your account.",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),

                  // 🧾 Form + Button
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Email", style: labelStyle()),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: emailCtrl,
                            autofocus: true,
                            autocorrect: false,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "youremail@domain.com",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: primaryRed, width: 2),
                              ),
                            ),
                            validator: (val) =>
                                val != null && val.contains('@') ? null : 'Enter a valid email',
                          ),
                          const SizedBox(height: 24),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Password", style: labelStyle()),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: passwordCtrl,
                            obscureText: true,
                            autocorrect: false,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "••••••••",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: primaryRed, width: 2),
                              ),
                            ),
                            validator: (val) =>
                                val != null && val.length >= 6 ? null : 'Min 6 characters',
                          ),

                          if (error != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],

                          const SizedBox(height: 40),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryRed,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: isLoading ? null : handleContinue,
                              child: isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
                                      'Continue',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          const Spacer(),

                          // 📜 Terms and Policy
                          Column(
                            children: [
                              const Text(
                                "By continuing, you agree to our",
                                style: TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => print("Terms tapped"),
                                    child: Text(
                                      "Terms of Service",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryRed,
                                      ),
                                    ),
                                  ),
                                  const Text(" and ",
                                      style: TextStyle(fontSize: 12, color: Colors.black54)),
                                  GestureDetector(
                                    onTap: () => print("Privacy tapped"),
                                    child: Text(
                                      "Privacy Policy",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryRed,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleContinue() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      // Try creating user to see if email already exists
      final tempCred = await auth.createUserWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text,
      );

      // ✅ Delete the temp user after checking (not ideal for prod but works for now)
      await tempCred.user?.delete();

      signupData.email = emailCtrl.text.trim();
      signupData.password = passwordCtrl.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SignupName(signupData: signupData),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          error = 'This email is already in use.';
        });
      } else {
        setState(() {
          error = e.message;
        });
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  TextStyle labelStyle() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
}
