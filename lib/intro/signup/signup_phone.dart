import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:mobile/nav.dart';
import 'signup_controller.dart';

class SignupPhone extends StatefulWidget {
  final SignupData signupData;
  const SignupPhone({super.key, required this.signupData});

  @override
  State<SignupPhone> createState() => _SignupPhoneState();
}

class _SignupPhoneState extends State<SignupPhone> {
  final phoneCtrl = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;
  String? error;

  final Color primaryRed = const Color(0xFFC50102);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (user != null) {
          Future.microtask(() {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Nav()),
              (route) => false,
            );
          });
        }

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
                  padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🧱 Top Text
                      const Text(
                        "What's your number?",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "We’ll text you to confirm it’s really you.",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
              
                      const SizedBox(height: 48),
              
                      // 📱 Form + Button grouped
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            autofocus: true,
                            controller: phoneCtrl,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixText: '+1 ',
                              hintText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: primaryRed, width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              MaskedInputFormatter('(###) ###-####')
                            ],
                            validator: (val) {
                              final cleaned = val?.replaceAll(RegExp(r'\D'), ''); // removes non-digits
                              if (cleaned == null || cleaned.length != 10) {
                                return 'Enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),
                          if (error != null) ...[
                            const SizedBox(height: 12),
                            Text(error!, style: const TextStyle(color: Colors.red)),
                          ],
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryRed,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () async {
                                print(widget.signupData.phoneNumber);
                                setState(() {
                                  isLoading = true;
                                  error = null;
                                });
              
                                try {
                                  await auth.createUserWithEmailAndPassword(
                                    email: widget.signupData.email,
                                    password: widget.signupData.password,
                                  );
                                  // Save data? (optional)
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    error = e.message;
                                    isLoading = false;
                                  });
                                }
                              },
                              child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    "Create Account",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                            ),
                          ),
                          
                        ],
                      ),
                      Spacer(),
              
                      // 📜 Agreement
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
                              const Text(" and ", style: TextStyle(fontSize: 12, color: Colors.black54)),
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
            ]
          ),
        );
      },
    );
  }
}
