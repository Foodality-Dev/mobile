
import 'package:flutter/material.dart';

final class QFButtonStyle {
  static ButtonStyle medium({Color backgroundColor = const Color(0xFF7FD7FF)}) {
    return TextButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        splashFactory: NoSplash.splashFactory,  //
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,  //
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        )
    );
  }
}