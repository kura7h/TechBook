import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Розділювач "—— або ——".
class OrDivider extends StatelessWidget {
  const OrDivider({super.key, this.text = 'або'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.divider, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.divider, height: 1)),
      ],
    );
  }
}
