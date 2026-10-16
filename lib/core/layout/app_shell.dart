import 'package:flutter/material.dart';

import '../router/app_navigator.dart';
import '../router/app_routes.dart';
import '../theme/app_colors.dart';
import 'app_sidebar.dart';
import 'nav_items.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.currentRoute,
    required this.child,
  });

  static const double wideBreakpoint = 900;
  static const double sidebarWidth = 260;

  final String currentRoute;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= wideBreakpoint;

    if (wide) {
      return Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: sidebarWidth,
              child: AppSidebar(currentRoute: currentRoute),
            ),
            Expanded(child: child),
          ],
        ),
      );
    }

    final items = [...mainNavItems, profileNavItem];
    var selectedIndex = items.indexWhere((i) => i.route == currentRoute);
    if (selectedIndex < 0) selectedIndex = 0;

    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.primarySoft,
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => AppNavigator.goTab(
          context,
          items[index].route,
          currentRoute,
        ),
        destinations: [
          for (final item in items)
            NavigationDestination(
              icon: Icon(item.icon, color: AppColors.textSecondary),
              selectedIcon: Icon(item.icon, color: AppColors.primary),
              label: item.shortLabel,
            ),
        ],
      ),
    );
  }
}

/// Позначка, що маршрут належить основним розділам (для зручності перевірок).
bool isShellRoute(String? route) {
  return route == AppRoutes.dashboard ||
      route == AppRoutes.garage ||
      route == AppRoutes.serviceLog ||
      route == AppRoutes.mileage ||
      route == AppRoutes.profile;
}
