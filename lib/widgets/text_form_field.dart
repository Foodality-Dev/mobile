import 'package:flutter/material.dart';


// // TODO: TEMP
// class KBFocusNode extends FocusNode {
//   // @override
//   // bool consumeKeyboardToken() {
//   //   // TODO: implement consumeKeyboardToken
//   //   return false;
//   // }
// }


final class QFInputDecoration {
  static InputDecoration large({required BuildContext context, String? hintText, Widget? suffixIcon, String? errorText}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
            width: 0.5,
            color: Colors.white.withOpacity(0.2)
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 0.5,
            color: Colors.white.withOpacity(0.2)
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 0.5,
            color: Colors.white.withOpacity(0.2)
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      hintText: hintText,
      errorText: errorText,
      errorMaxLines: 3,
      hintStyle: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(color: Colors.white.withOpacity(0.25)),
      suffixIcon: suffixIcon,
    );
  }

  static InputDecoration medium({
    required BuildContext context,
    required double deviceWidth,
    required double deviceHeight,
    String? errorText,
    Color fillColor = const Color.fromRGBO(38, 41, 48, 1),
  }) {
    return InputDecoration(
      counterStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.75)),
      contentPadding: EdgeInsets.fromLTRB(deviceWidth * 23 / 390, deviceHeight * 8 / 845, deviceWidth * 23 / 390, deviceHeight * 8 / 845),
      fillColor: fillColor,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      errorText: errorText,
      errorMaxLines: 3,
    );
  }

  static InputDecoration mediumMultiline(BuildContext context, double deviceWidth, double deviceHeight) {
    return InputDecoration(
        counterStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
          color: const Color.fromRGBO(255, 255, 255, 0.75),
          fontWeight: FontWeight.w500,
        ),
        contentPadding: EdgeInsets.fromLTRB(deviceWidth * 23 / 390, deviceHeight * 8 / 845, deviceWidth * 23 / 390, deviceHeight * 8 / 845),
        fillColor: const Color.fromRGBO(38, 41, 48, 1),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
    );
  }

  // inputSmall() if needed
}



// Regular text form field
class QFTextFormField extends StatelessWidget {
  const QFTextFormField({
    super.key,
    required this.controller,
    required this.textInputAction,
    required this.validator,
    required this.decoration,
    this.autofillHints,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?) validator;
  final InputDecoration decoration;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      autocorrect: false,
      autofillHints: autofillHints,
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      decoration: decoration,
    );
  }
}


class QFPasswordFormField extends StatefulWidget {
  const QFPasswordFormField({
    super.key,
    required this.controller,
    required this.textInputAction,
    required this.hintText,
    this.errorText,
    this.actualPasswordController,
    this.firstTime = false,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? hintText;
  final String? errorText;
  final TextEditingController? actualPasswordController;
  final bool firstTime;

  @override
  State<QFPasswordFormField> createState() => _QFPasswordFormFieldState();
}

class _QFPasswordFormFieldState extends State<QFPasswordFormField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      autocorrect: false,
      autofillHints: widget.actualPasswordController == null ? [widget.firstTime ? AutofillHints.newPassword : AutofillHints.password] : [],
      controller: widget.controller,
      validator: (value) {
        if (widget.actualPasswordController != null && widget.actualPasswordController!.text != value) {
          return 'Confirmation password does not match';
        } else if (value == null || value.isEmpty) {
          return 'Please enter a password';
        } else if (value.length < 6) {
          return 'Password must be more than 6 characters';
        }
        return null;
      },
      textInputAction: widget.textInputAction,
      obscureText: !visible,
      decoration: QFInputDecoration.large(
        context: context, hintText: widget.hintText, errorText: widget.errorText,
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
            color: Colors.white.withOpacity(0.25),
          ),
          splashColor: Colors.transparent,
          onPressed: () {
            setState( () {
              visible = !visible;
            });
          },
        ),
      ),
    );
  }
}



class QFEmailFormField extends StatelessWidget {
  const QFEmailFormField({
    super.key,
    required this.controller,
    required this.textInputAction,
    required this.hintText,
    this.errorText,
    this.checkRegistered = false,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? hintText;
  final String? errorText;
  final bool checkRegistered;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.email],
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        } else if (!RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$')
            .hasMatch(value.toLowerCase().trim())
        ) {  //  !EmailValidator.validate(value.trim())
          return 'Email address invalid';
        }
        return null;
      },
      textInputAction: textInputAction,
      decoration: QFInputDecoration.large(context: context, hintText: hintText, errorText: errorText),
    );
  }
}