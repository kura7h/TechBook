import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Плашка з державним номером автомобіля.
class PlateChip extends StatelessWidget {
  const PlateChip({super.key, required this.plate, this.onDark = false});

  final String plate;

  /// true – напівпрозорий темний фон (для розміщення поверх фото).
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: onDark ? const Color(0x99111827) : AppColors.primarySoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        plate,
        style: AppTextStyles.mono(
          size: 14,
          weight: FontWeight.w700,
          color: onDark ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }
}
