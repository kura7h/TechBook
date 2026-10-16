import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_dropdown.dart';
import '../../core/widgets/page_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/mock_data.dart';
import '../../data/models/mileage_entry.dart';
import 'widgets/add_mileage_dialog.dart';
import 'widgets/mileage_tile.dart';

class MileageScreen extends StatefulWidget {
  const MileageScreen({super.key});

  @override
  State<MileageScreen> createState() => _MileageScreenState();
}

class _MileageScreenState extends State<MileageScreen> {
  String _carId = MockData.cars.first.id;

  Future<void> _addEntry() async {
    final entry = await showDialog<MileageEntry>(
      context: context,
      builder: (context) => AddMileageDialog(initialCarId: _carId),
    );
    if (entry != null && mounted) {
      setState(() {
        MockData.addMileageEntry(entry);
        _carId = entry.carId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = MockData.mileageFor(_carId);

    return PageScaffold(
      title: 'Облік пробігу',
      actions: [
        SizedBox(
          width: 220,
          child: AppDropdown<String>(
            dense: true,
            value: _carId,
            items: [
              for (final car in MockData.cars)
                DropdownMenuItem<String>(
                  value: car.id,
                  child: Text(car.name, overflow: TextOverflow.ellipsis),
                ),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _carId = value);
            },
          ),
        ),
        PrimaryButton(
          label: 'Додати запис',
          icon: Icons.add,
          expand: false,
          dense: true,
          onPressed: _addEntry,
        ),
      ],
      children: [
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                child: Text('Хронологія', style: AppTextStyles.sectionTitle),
              ),
              const Divider(height: 1, color: AppColors.divider),
              if (entries.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'Записів пробігу ще немає',
                      style: AppTextStyles.caption,
                    ),
                  ),
                )
              else
                for (var i = 0; i < entries.length; i++) ...[
                  MileageTile(
                    entry: entries[i],
                    delta: i + 1 < entries.length
                        ? entries[i].odometer - entries[i + 1].odometer
                        : null,
                    onDelete: () => setState(
                      () => MockData.removeMileageEntry(entries[i].id),
                    ),
                  ),
                  if (i != entries.length - 1)
                    const Divider(height: 1, color: AppColors.divider),
                ],
            ],
          ),
        ),
      ],
    );
  }
}
