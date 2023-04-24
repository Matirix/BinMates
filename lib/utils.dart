import 'package:flutter/material.dart';

/// This is a utility class that contains functions that are used throughout the app
class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  /// This function is used to show a snackbar ( a small window popup at the bottom of the screen)
  /// Used for errors or successfull adding of adocument to the database
  static showSnackBar(String? text, Color? color) {
    if (text == null) return;
    final snackBar = SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
        backgroundColor: color);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
