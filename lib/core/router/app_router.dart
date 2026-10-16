import 'package:flutter/material.dart';

import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/garage/garage_screen.dart';
import '../../features/mileage/mileage_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/service_log/service_log_screen.dart';
import '../layout/app_shell.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.register:
        return _page(settings, const RegisterScreen());
      case AppRoutes.forgotPassword:
        return _page(settings, const ForgotPasswordScreen());
      case AppRoutes.dashboard:
        return _shell(settings, const DashboardScreen());
      case AppRoutes.garage:
        return _shell(settings, const GarageScreen());
      case AppRoutes.serviceLog:
        return _shell(settings, const ServiceLogScreen());
      case AppRoutes.mileage:
        return _shell(settings, const MileageScreen());
      case AppRoutes.profile:
        return _shell(settings, const ProfileScreen());
      case AppRoutes.login:
      default:
        return _page(settings, const LoginScreen());
    }
  }

  /// Звичайний екран (авторизація) зі стандартною анімацією переходу.
  static Route<dynamic> _page(RouteSettings settings, Widget screen) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => screen,
    );
  }

  /// Екран основного розділу всередині оболонки з меню; перемикання
  static Route<dynamic> _shell(RouteSettings settings, Widget screen) {
    return PageRouteBuilder<void>(
      settings: settings,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) => AppShell(
        currentRoute: settings.name ?? AppRoutes.dashboard,
        child: screen,
      ),
    );
  }
}
