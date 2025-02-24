import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/text_button.dart';
import 'reset_password.dart';

class ForgotPasswordEmailCodeVerify extends StatefulWidget {
  const ForgotPasswordEmailCodeVerify({super.key, required this.emailAddress});

  final String emailAddress;  // assumes valid email address

  @override
  State<ForgotPasswordEmailCodeVerify> createState() => _ForgotPasswordEmailCodeVerifyState();
}

class _ForgotPasswordEmailCodeVerifyState extends State<ForgotPasswordEmailCodeVerify> {
  final _formKey = GlobalKey<FormState>();

  late int code;

  bool verifyEnabled = false;
  TextEditingController pinController = TextEditingController();

  void sendCode() {
    regenCode();
    // TODO: add a temp snackbar notif at the bottom?
  }

  void regenCode() {
    // TODO secure code generation
    code = 0;
  }

  @override
  Widget build(BuildContext context) {
    sendCode();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  "Enter Verification Code",
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Text(
                  "we sent an email to",
                  style: Theme.of(context).primaryTextTheme.labelSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, bottom: 36.0),
                child: Text(
                  widget.emailAddress,
                  style: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(color: const Color(0xff7fd7ff)),
                ),
              ),
              PinCodeTextField(
                appContext: context,
                length: 4,
                controller: pinController,
                validator: (value) {
                  // assumes the input will always be filled (4 digit)
                  // TODO
                  return null;
                },
                onCompleted: (value) {
                  setState(() {
                    verifyEnabled = true;
                  });
                },
                onChanged: (value) {
                  // verifyEnabled means all inputs are filled, if changed
                  // it can only mean the user removed a pin
                  if (verifyEnabled) {
                    setState(() {
                      verifyEnabled = false;
                    });
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                mainAxisAlignment: MainAxisAlignment.center,
                enableActiveFill: true,
                textStyle: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                  color: const Color(0xFF7FD7FF),
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  inactiveColor: const Color.fromRGBO(255, 255, 255, 0.2),
                  inactiveFillColor: Colors.transparent,
                  selectedColor: const Color.fromRGBO(127, 215, 255, 1),
                  selectedFillColor: const Color.fromRGBO(127, 215, 255, 0.15),
                  activeColor: const Color.fromRGBO(127, 215, 255, 1),
                  activeFillColor: Colors.transparent,
                  fieldWidth: 70.0,
                  fieldHeight: 60.0,
                  fieldOuterPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                ),
              ),
              TextButton(
                onPressed: () {
                  sendCode();
                },
                child: Text(
                  "Resend Code Again",
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                child: TextButton(
                  onPressed: () {
                    if (verifyEnabled) {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPassword()
                          ),
                        );
                      }
                    }
                  },
                  style: QFButtonStyle.medium(
                    backgroundColor: verifyEnabled ? const Color(0xFF7FD7FF) : const Color(0xFF262930),
                  ),
                  child: Text(
                    "verify now",
                    style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(
                      color: verifyEnabled ? const Color(0xFF181A1E) : const Color.fromRGBO(255, 255, 255, 0.5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: MediaQuery.of(context).size.width / 8),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: QFButtonStyle.medium(backgroundColor: const Color(0xFF262930)),
                  child: Text(
                    "return",
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