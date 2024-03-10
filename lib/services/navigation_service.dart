import 'package:flutter/material.dart';

class NavigationService {
  static void navigateTo(BuildContext context, Widget route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route)
    );
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}