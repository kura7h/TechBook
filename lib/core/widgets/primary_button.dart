import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
    this.dense = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  final bool expand;

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final style = FilledButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: AppColors.primaryDisabled,
      disabledForegroundColor: Colors.white,
      elevation: 0,
      minimumSize: Size(0, dense ? 48 : 52),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );

    final Widget button = icon == null
        ? FilledButton(
            onPressed: onPressed,
            style: style,
            child: Text(label),
          )
        : FilledButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(icon, size: 20),
            label: Text(label),
          );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
