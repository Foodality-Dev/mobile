import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_limiter/rate_limiter.dart';

import '../../widgets/text_button.dart';
import '../../widgets/text_form_field.dart';
// import 'email_code_verify.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool sendCodeRateLimitEnabled = false;
  bool firstCodeSent = false;

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final debouncedEmailFalling = debounce(
      () => setState(() {sendCodeRateLimitEnabled = false;}),
      const Duration(seconds: 5),
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 140.0),
                child: Text(
                  "forgot password",
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 36.0),
                child: Text(
                  "enter your email to receive a link",
                  style: Theme.of(context).primaryTextTheme.labelSmall,
                ),
              ),
              QFEmailFormField(
                controller: emailController,
                textInputAction: TextInputAction.done,
                hintText: "your email",
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: check if the email address is registered; if not, ..?
                  if (_formKey.currentState!.validate() && !sendCodeRateLimitEnabled) {
                    debouncedEmailFalling();
                    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

                    if (!firstCodeSent) {
                      setState(() {
                        firstCodeSent = true;
                      });
                    }

                    setState(() {
                      sendCodeRateLimitEnabled = true;
                    });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => ForgotPasswordEmailCodeVerify(emailAddress: emailController.text)
                    //   ),
                    // );
                  }
                },
                style: QFButtonStyle.medium(
                  backgroundColor: sendCodeRateLimitEnabled ? const Color(0xFF262930) : const Color(0xFF7FD7FF),
                ),
                child: Text(
                  firstCodeSent ? "Send Code Again" : "Send Code",
                  style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(
                    color: sendCodeRateLimitEnabled ? const Color.fromRGBO(255, 255, 255, 0.5) : const Color(0xFF181A1E),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: QFButtonStyle.medium(backgroundColor: const Color(0xFF262930)),
                  child: Text(
                    firstCodeSent ? "return" : "cancel",
                    style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}