import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../../core/widgets/app_dropdown.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/car_photo.dart';
import '../../../core/widgets/dashed_border.dart';
import '../../../core/widgets/field_label.dart';
import '../../../core/widgets/field_row.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../data/mock_data.dart';
import '../../../data/models/car.dart';

class AddCarDialog extends StatefulWidget {
  const AddCarDialog({super.key});

  @override
  State<AddCarDialog> createState() => _AddCarDialogState();
}

class _AddCarDialogState extends State<AddCarDialog> {
  final _brand = TextEditingController();
  final _model = TextEditingController();
  final _year = TextEditingController(text: DateTime.now().year.toString());
  final _plate = TextEditingController();
  final _vin = TextEditingController();
  final _volume = TextEditingController();
  final _mileage = TextEditingController(text: '0');

  String _fuel = Car.fuelTypes.first;

  bool _hasPhoto = false;

  @override
  void initState() {
    super.initState();
    _brand.addListener(_refresh);
    _model.addListener(_refresh);
  }

  @override
  void dispose() {
    _brand.dispose();
    _model.dispose();
    _year.dispose();
    _plate.dispose();
    _vin.dispose();
    _volume.dispose();
    _mileage.dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  bool get _canSave =>
      _brand.text.trim().isNotEmpty && _model.text.trim().isNotEmpty;

  void _save() {
    Navigator.of(context).pop(
      Car(
        id: MockData.nextId('car'),
        brand: _brand.text.trim(),
        model: _model.text.trim(),
        year: int.tryParse(_year.text) ?? DateTime.now().year,
        plate: _plate.text.trim(),
        vin: _vin.text.trim(),
        fuel: _fuel,
        engineVolume: double.tryParse(_volume.text.replaceAll(',', '.')) ?? 0,
        mileage: int.tryParse(_mileage.text) ?? 0,
        photoAsset: _hasPhoto ? MockData.camryPhoto : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: 'Додати автомобіль',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const FieldLabel('Фото автомобіля'),
          const SizedBox(height: 6),
          _PhotoPicker(
            hasPhoto: _hasPhoto,
            onTap: () => setState(() => _hasPhoto = !_hasPhoto),
          ),
          const SizedBox(height: 16),
          FieldRow(
            left: AppTextField(
              controller: _brand,
              label: 'Марка',
              hint: 'Toyota',
              dense: true,
              textCapitalization: TextCapitalization.words,
            ),
            right: AppTextField(
              controller: _model,
              label: 'Модель',
              hint: 'Camry',
              dense: true,
              textCapitalization: TextCapitalization.words,
            ),
          ),
          const SizedBox(height: 14),
          FieldRow(
            left: AppTextField(
              controller: _year,
              label: 'Рік',
              dense: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
            ),
            right: AppTextField(
              controller: _plate,
              label: 'Держ. номер',
              hint: 'AA 1234 BC',
              dense: true,
              textCapitalization: TextCapitalization.characters,
            ),
          ),
          const SizedBox(height: 14),
          FieldRow(
            left: AppTextField(
              controller: _vin,
              label: 'VIN-код',
              hint: '1HGCM82633A...',
              dense: true,
              textCapitalization: TextCapitalization.characters,
            ),
            right: AppDropdown<String>(
              label: 'Тип пального',
              dense: true,
              value: _fuel,
              items: [
                for (final fuel in Car.fuelTypes)
                  DropdownMenuItem<String>(
                    value: fuel,
                    child: Text(fuel, overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _fuel = value);
              },
            ),
          ),
          const SizedBox(height: 14),
          FieldRow(
            left: AppTextField(
              controller: _volume,
              label: "Об'єм (L)",
              hint: '2.5',
              dense: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
            ),
            right: AppTextField(
              controller: _mileage,
              label: 'Пробіг (км)',
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
                label: 'Додати',
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

/// Область «фото автомобіля»: заглушка або попередній перегляд.
class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({required this.hasPhoto, required this.onTap});

  final bool hasPhoto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: hasPhoto
          ? GestureDetector(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: const CarPhoto(asset: MockData.camryPhoto),
              ),
            )
          : DashedBorder(
              radius: 16,
              child: Material(
                color: AppColors.tile,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: onTap,
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Натисніть, щоб додати фото',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
