import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/type_badge.dart';
import '../../../data/models/service_record.dart';

const double _costColumnWidth = 160;

class ServiceTableHeader extends StatelessWidget {
  const ServiceTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cell(String text, {TextAlign align = TextAlign.left}) => Text(
          text,
          textAlign: align,
          style: AppTextStyles.fieldLabel.copyWith(letterSpacing: 0.8),
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Expanded(flex: 5, child: cell('ОПИС')),
          Expanded(flex: 2, child: cell('ТИП')),
          Expanded(flex: 2, child: cell('АВТОМОБІЛЬ')),
          Expanded(flex: 2, child: cell('ДАТА / ПРОБІГ')),
          SizedBox(
            width: _costColumnWidth,
            child: cell('ВАРТІСТЬ', align: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

class ServiceRecordRow extends StatelessWidget {
  const ServiceRecordRow({
    super.key,
    required this.record,
    required this.carName,
    required this.onDelete,
  });

  final ServiceRecord record;
  final String carName;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                _Dot(color: recordTypeColor(record.type)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    record.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TypeBadge(type: record.type),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(carName, style: AppTextStyles.caption),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatDate(record.date),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  formatKm(record.mileage),
                  style: AppTextStyles.mono(
                    size: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: _costColumnWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    formatUah(record.totalCost),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.success,
                    ),
                  ),
                ),
                _DeleteButton(onPressed: onDelete),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceRecordCompactTile extends StatelessWidget {
  const ServiceRecordCompactTile({
    super.key,
    required this.record,
    required this.carName,
    required this.onDelete,
  });

  final ServiceRecord record;
  final String carName;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: _Dot(color: recordTypeColor(record.type)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.description, style: AppTextStyles.bodyBold),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 10,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    TypeBadge(type: record.type),
                    Text(carName, style: AppTextStyles.caption),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${formatDate(record.date)} · ${formatKm(record.mileage)}',
                  style: AppTextStyles.mono(
                    size: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatUah(record.totalCost),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.success,
                ),
              ),
              _DeleteButton(onPressed: onDelete),
            ],
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Видалити',
      visualDensity: VisualDensity.compact,
      icon: const Icon(
        Icons.delete_outline,
        size: 20,
        color: AppColors.textSecondary,
      ),
      onPressed: onPressed,
    );
  }
}
