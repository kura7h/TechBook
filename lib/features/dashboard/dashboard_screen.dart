import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/car_photo.dart';
import '../../core/widgets/page_scaffold.dart';
import '../../core/widgets/plate_chip.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';
import '../../core/widgets/stat_card.dart';
import '../../core/widgets/type_badge.dart';
import '../../data/mock_data.dart';
import '../../data/models/car.dart';
import '../../data/models/mileage_entry.dart';
import '../../data/models/service_record.dart';
import '../mileage/widgets/add_mileage_dialog.dart';
import 'add_service_record_dialog.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _carId = MockData.cars.first.id;

  Car get _car => MockData.carById(_carId) ?? MockData.cars.first;

  Future<void> _addRecord() async {
    final record = await showDialog<ServiceRecord>(
      context: context,
      builder: (context) => AddServiceRecordDialog(initialCarId: _car.id),
    );
    if (record != null && mounted) {
      setState(() {
        MockData.addServiceRecord(record);
        _carId = record.carId;
      });
    }
  }

  Future<void> _addMileage() async {
    final entry = await showDialog<MileageEntry>(
      context: context,
      builder: (context) => AddMileageDialog(initialCarId: _car.id),
    );
    if (entry != null && mounted) {
      setState(() {
        MockData.addMileageEntry(entry);
        _carId = entry.carId;
      });
    }
  }

  /// Витрати за місяць останнього запису (демо-дані фіксовані у часі).
  int _monthlySpend(List<ServiceRecord> records) {
    if (records.isEmpty) return 0;
    final latest = records.first.date; // records відсортовані за датою
    return records
        .where(
            (r) => r.date.year == latest.year && r.date.month == latest.month)
        .fold<int>(0, (sum, r) => sum + r.totalCost);
  }

  @override
  Widget build(BuildContext context) {
    final car = _car;
    final records = MockData.recordsFor(carId: car.id);
    final totalSpend = records.fold<int>(0, (sum, r) => sum + r.totalCost);
    final monthlySpend = _monthlySpend(records);
    final recent = records.take(3).toList();

    return PageScaffold(
      title: 'Журнал авто',
      actions: [
        SecondaryButton(
          label: 'Додати пробіг',
          icon: Icons.speed_outlined,
          expand: false,
          dense: true,
          onPressed: _addMileage,
        ),
        PrimaryButton(
          label: 'Додати запис',
          icon: Icons.add,
          expand: false,
          dense: true,
          onPressed: _addRecord,
        ),
      ],
      children: [
        _CarSummaryCard(
          car: car,
          onCarSelected: (id) => setState(() => _carId = id),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final cards = [
              StatCard(
                title: 'Витрати за місяць',
                value: formatUahSymbol(monthlySpend),
                icon: Icons.trending_up,
                iconColor: AppColors.primary,
                iconBackground: AppColors.primarySoft,
              ),
              StatCard(
                title: 'Загальні витрати',
                value: formatUahSymbol(totalSpend),
                icon: Icons.build_outlined,
                iconColor: AppColors.purple,
                iconBackground: AppColors.purpleSoft,
              ),
              StatCard(
                title: 'Поточний пробіг',
                value: formatKm(car.mileage),
                icon: Icons.speed_outlined,
                iconColor: AppColors.success,
                iconBackground: AppColors.successSoft,
              ),
            ];

            if (constraints.maxWidth < 720) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    cards[i],
                    if (i != cards.length - 1) const SizedBox(height: 12),
                  ],
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < cards.length; i++) ...[
                  Expanded(child: cards[i]),
                  if (i != cards.length - 1) const SizedBox(width: 16),
                ],
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                child:
                    Text('Останні записи', style: AppTextStyles.sectionTitle),
              ),
              const Divider(height: 1, color: AppColors.divider),
              if (recent.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'Записів обслуговування ще немає',
                      style: AppTextStyles.caption,
                    ),
                  ),
                )
              else
                for (var i = 0; i < recent.length; i++) ...[
                  _RecentRecordTile(record: recent[i]),
                  if (i != recent.length - 1)
                    const Divider(height: 1, color: AppColors.divider),
                ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CarSummaryCard extends StatelessWidget {
  const _CarSummaryCard({required this.car, required this.onCarSelected});

  final Car car;
  final ValueChanged<String> onCarSelected;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primaryTint,
      borderColor: AppColors.primaryTintBorder,
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.name,
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      car.shortSpec,
                      style: AppTextStyles.subtitle,
                    ),
                    PlateChip(plate: car.plate),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Пробіг', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatKm(car.mileage),
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 80,
                  height: 56,
                  child: CarPhoto(asset: car.photoAsset),
                ),
              ),
              const SizedBox(height: 8),
              PopupMenuButton<String>(
                tooltip: 'Обрати автомобіль',
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                ),
                onSelected: onCarSelected,
                itemBuilder: (context) => [
                  for (final item in MockData.cars)
                    PopupMenuItem<String>(
                      value: item.id,
                      child: Text(item.label),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentRecordTile extends StatelessWidget {
  const _RecentRecordTile({required this.record});

  final ServiceRecord record;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(record.description, style: AppTextStyles.bodyBold),
                    TypeBadge(type: record.type),
                  ],
                ),
                const SizedBox(height: 4),
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
          const SizedBox(width: 12),
          Text(
            formatUah(record.totalCost),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}
