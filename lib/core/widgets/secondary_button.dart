import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconColor = AppColors.primary,
    this.expand = true,
    this.dense = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color iconColor;
  final bool expand;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final style = OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.textPrimary,
      side: const BorderSide(color: AppColors.divider),
      elevation: 0,
      minimumSize: Size(0, dense ? 48 : 52),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );

    final Widget button = icon == null
        ? OutlinedButton(
            onPressed: onPressed,
            style: style,
            child: Text(label),
          )
        : OutlinedButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(icon, size: 20, color: iconColor),
            label: Text(label),
          );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
