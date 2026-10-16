import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/router/app_router.dart';
import 'core/router/app_routes.dart';
import 'core/theme/app_theme.dart';

class TechBookApp extends StatelessWidget {
  const TechBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechBook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      locale: const Locale('uk'),
      supportedLocales: const [Locale('uk'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
