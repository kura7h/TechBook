import 'package:flutter/material.dart';

import '../router/app_routes.dart';

class NavItem {
  const NavItem({
    required this.route,
    required this.label,
    required this.shortLabel,
    required this.icon,
  });

  final String route;
  final String label;
  final String shortLabel;
  final IconData icon;
}

const List<NavItem> mainNavItems = [
  NavItem(
    route: AppRoutes.dashboard,
    label: 'Дашборд',
    shortLabel: 'Дашборд',
    icon: Icons.grid_view_outlined,
  ),
  NavItem(
    route: AppRoutes.garage,
    label: 'Гараж',
    shortLabel: 'Гараж',
    icon: Icons.directions_car_outlined,
  ),
  NavItem(
    route: AppRoutes.serviceLog,
    label: 'Журнал ТО',
    shortLabel: 'ТО',
    icon: Icons.build_outlined,
  ),
  NavItem(
    route: AppRoutes.mileage,
    label: 'Пробіг',
    shortLabel: 'Пробіг',
    icon: Icons.speed_outlined,
  ),
];

const NavItem profileNavItem = NavItem(
  route: AppRoutes.profile,
  label: 'Профіль',
  shortLabel: 'Профіль',
  icon: Icons.person_outline,
);
