import 'package:flutter/material.dart';
import 'signup_controller.dart';
import 'signup_phone.dart';

class SignupName extends StatefulWidget {
  final SignupData signupData;
  const SignupName({super.key, required this.signupData});

  @override
  State<SignupName> createState() => _SignupNameState();
}

class _SignupNameState extends State<SignupName> {
  final usernameCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
                    "Let’s fill in your details",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "We’re almost there. Add your personal info to finish signing up.",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),
          
                  // 🧾 Form
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Username
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Username", style: labelStyle()),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: usernameCtrl,
                            autofocus: true,
                            autocorrect: false,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "foodie123",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: primaryRed, width: 2),
                              ),
                            ),
                            validator: (val) =>
                                val != null && val.length >= 3 ? null : "Enter a valid username",
                          ),
                          const SizedBox(height: 20),
          
                          // First name
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("First name", style: labelStyle()),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: firstNameCtrl,
                            autocorrect: false,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "John",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: primaryRed, width: 2),
                              ),
                            ),
                            validator: (val) =>
                                val != null && val.isNotEmpty ? null : "Required",
                          ),
                          const SizedBox(height: 20),
          
                          // Last name
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Last name", style: labelStyle()),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: lastNameCtrl,
                            autocorrect: false,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Smith",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: primaryRed, width: 2),
                              ),
                            ),
                            validator: (val) =>
                                val != null && val.isNotEmpty ? null : "Required",
                          ),
                          const SizedBox(height: 40),
          
                          // 🔘 Continue Button
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  widget.signupData.username = usernameCtrl.text.trim();
                                  widget.signupData.firstName = firstNameCtrl.text.trim();
                                  widget.signupData.lastName = lastNameCtrl.text.trim();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          SignupPhone(signupData: widget.signupData),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }

  TextStyle labelStyle() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
}
