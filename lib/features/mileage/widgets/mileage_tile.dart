import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/mileage_entry.dart';

class MileageTile extends StatelessWidget {
  const MileageTile({
    super.key,
    required this.entry,
    required this.delta,
    required this.onDelete,
  });

  final MileageEntry entry;

  final int? delta;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatKm(entry.odometer),
                  style: AppTextStyles.mono(
                    size: 20,
                    weight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(formatDateLong(entry.date), style: AppTextStyles.caption),
              ],
            ),
          ),
          if (delta != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.successSoft,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '+${formatKm(delta!)}',
                style: AppTextStyles.mono(
                  size: 14,
                  weight: FontWeight.w700,
                  color: AppColors.success,
                ),
              ),
            ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Видалити',
            icon: const Icon(
              Icons.delete_outline,
              size: 20,
              color: AppColors.textSecondary,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
