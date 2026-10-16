import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppNavigator {
  AppNavigator._();

  static void goTab(BuildContext context, String route, String current) {
    if (route == current) return;
    Navigator.of(context).pushReplacementNamed(route);
  }

  static void enterApp(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.dashboard,
      (route) => false,
    );
  }

  static void logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }
}
