import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/widgets/app_date_field.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../../core/widgets/app_dropdown.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/field_row.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../data/mock_data.dart';
import '../../../data/models/mileage_entry.dart';

class AddMileageDialog extends StatefulWidget {
  const AddMileageDialog({super.key, this.initialCarId});

  final String? initialCarId;

  @override
  State<AddMileageDialog> createState() => _AddMileageDialogState();
}

class _AddMileageDialogState extends State<AddMileageDialog> {
  late String _carId = widget.initialCarId ?? MockData.cars.first.id;
  DateTime? _date;
  final _odometer = TextEditingController();

  @override
  void initState() {
    super.initState();
    _odometer.addListener(_refresh);
  }

  @override
  void dispose() {
    _odometer.dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  bool get _canSave => _date != null && (int.tryParse(_odometer.text) ?? 0) > 0;

  void _save() {
    Navigator.of(context).pop(
      MileageEntry(
        id: MockData.nextId('m'),
        carId: _carId,
        date: _date!,
        odometer: int.parse(_odometer.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: 'Новий запис пробігу',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppDropdown<String>(
            label: 'Автомобіль',
            dense: true,
            value: _carId,
            items: [
              for (final car in MockData.cars)
                DropdownMenuItem<String>(
                  value: car.id,
                  child: Text(car.label, overflow: TextOverflow.ellipsis),
                ),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _carId = value);
            },
          ),
          const SizedBox(height: 14),
          FieldRow(
            left: AppDateField(
              label: 'Дата',
              value: _date,
              onChanged: (value) => setState(() => _date = value),
            ),
            right: AppTextField(
              controller: _odometer,
              label: 'Пробіг (км)',
              hint: '0',
              dense: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SecondaryButton(
                label: 'Скасувати',
                expand: false,
                dense: true,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 12),
              PrimaryButton(
                label: 'Зберегти',
                expand: false,
                dense: true,
                onPressed: _canSave ? _save : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
