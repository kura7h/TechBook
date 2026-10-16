import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const List<String> _monoFallback = [
    'Roboto Mono',
    'Menlo',
    'Consolas',
    'Courier New',
  ];

  /// Моноширинний шрифт (держномери, VIN, пробіг у списках).
  static TextStyle mono({
    double size = 14,
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: 'monospace',
      fontFamilyFallback: _monoFallback,
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  static const pageTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.15,
  );

  static const authTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const logo = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
    letterSpacing: -1,
  );

  static const sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const body = TextStyle(
    fontSize: 15,
    color: AppColors.textPrimary,
  );

  static const bodyBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const caption = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const fieldLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
    color: AppColors.textSecondary,
  );
}
