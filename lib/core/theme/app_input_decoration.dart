import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppInputDecoration {
  AppInputDecoration._();

  static InputDecoration build({
    String? hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool dense = false,
  }) {
    final radius = BorderRadius.circular(dense ? 12 : 16);

    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.textHint,
        fontSize: dense ? 14 : 16,
      ),
      filled: true,
      fillColor: Colors.white,
      isDense: dense,
      contentPadding: EdgeInsets.symmetric(
        horizontal: dense ? 14 : 16,
        vertical: dense ? 13 : 16,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: border(AppColors.border),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.primary, 1.6),
    );
  }
}
