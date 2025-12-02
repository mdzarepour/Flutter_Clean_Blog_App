import 'package:flutter/material.dart';

class WidgetHelper {
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

  void showBottomSheet({required List<Widget> children}) {
    showModalBottomSheet(
      useSafeArea: true,
      context: navigatorKey.currentContext!,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            spacing: 15,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        );
      },
    );
  }
}
