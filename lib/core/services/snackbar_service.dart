import 'package:flutter/material.dart';

class SnackbarService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void showSnackbar({required String message}) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
        content: Text(textAlign: TextAlign.center, message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
