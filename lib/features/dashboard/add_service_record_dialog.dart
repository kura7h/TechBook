import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_date_field.dart';
import '../../core/widgets/app_dialog.dart';
import '../../core/widgets/app_dropdown.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/field_label.dart';
import '../../core/widgets/field_row.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';
import '../../data/mock_data.dart';
import '../../data/models/part.dart';
import '../../data/models/record_type.dart';
import '../../data/models/service_record.dart';

class AddServiceRecordDialog extends StatefulWidget {
  const AddServiceRecordDialog({super.key, this.initialCarId});

  final String? initialCarId;

  @override
  State<AddServiceRecordDialog> createState() => _AddServiceRecordDialogState();
}

class _PartInput {
  _PartInput(VoidCallback onChanged) {
    for (final controller in [name, manufacturer, quantity, price]) {
      controller.addListener(onChanged);
    }
  }

  final Key key = UniqueKey();
  final name = TextEditingController();
  final manufacturer = TextEditingController();
  final quantity = TextEditingController(text: '1');
  final price = TextEditingController(text: '0');

  int get total =>
      (int.tryParse(quantity.text) ?? 0) * (int.tryParse(price.text) ?? 0);

  void dispose() {
    name.dispose();
    manufacturer.dispose();
    quantity.dispose();
    price.dispose();
  }
}

class _AddServiceRecordDialogState extends State<AddServiceRecordDialog> {
  late String _carId = widget.initialCarId ?? MockData.cars.first.id;
  RecordType _type = RecordType.maintenance;
  DateTime? _date;

  final _mileage = TextEditingController(text: '0');
  final _workCost = TextEditingController(text: '0');
  final _description = TextEditingController();
  late final List<_PartInput> _parts = [_PartInput(_refresh)];

  @override
  void initState() {
    super.initState();
    _mileage.addListener(_refresh);
    _workCost.addListener(_refresh);
    _description.addListener(_refresh);
  }

  @override
  void dispose() {
    _mileage.dispose();
    _workCost.dispose();
    _description.dispose();
    for (final part in _parts) {
      part.dispose();
    }
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  bool get _canSave => _date != null && _description.text.trim().isNotEmpty;

  int get _totalCost {
    final work = int.tryParse(_workCost.text) ?? 0;
    final parts = _parts.fold<int>(0, (sum, part) => sum + part.total);
    return work + parts;
  }

  void _addPart() => setState(() => _parts.add(_PartInput(_refresh)));

  void _removePart(_PartInput part) {
    setState(() => _parts.remove(part));
    WidgetsBinding.instance.addPostFrameCallback((_) => part.dispose());
  }

  void _save() {
    final parts = <Part>[
      for (final input in _parts)
        if (input.name.text.trim().isNotEmpty || input.total > 0)
          Part(
            name: input.name.text.trim().isEmpty
                ? 'Деталь'
                : input.name.text.trim(),
            manufacturer: input.manufacturer.text.trim(),
            quantity: int.tryParse(input.quantity.text) ?? 1,
            price: int.tryParse(input.price.text) ?? 0,
          ),
    ];

    Navigator.of(context).pop(
      ServiceRecord(
        id: MockData.nextId('rec'),
        carId: _carId,
        type: _type,
        date: _date!,
        mileage: int.tryParse(_mileage.text) ?? 0,
        workCost: int.tryParse(_workCost.text) ?? 0,
        description: _description.text.trim(),
        parts: parts,
      ),
    );
  }

  static final List<TextInputFormatter> _digitsOnly = [
    FilteringTextInputFormatter.digitsOnly,
  ];

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: 'Новий запис обслуговування',
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
            left: AppDropdown<RecordType>(
              label: 'Тип',
              dense: true,
              value: _type,
              items: [
                for (final type in RecordType.values)
                  DropdownMenuItem<RecordType>(
                    value: type,
                    child: Text(type.label),
                  ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _type = value);
              },
            ),
            right: AppDateField(
              label: 'Дата',
              value: _date,
              onChanged: (value) => setState(() => _date = value),
            ),
          ),
          const SizedBox(height: 14),
          FieldRow(
            left: AppTextField(
              controller: _mileage,
              label: 'Пробіг (км)',
              dense: true,
              keyboardType: TextInputType.number,
              inputFormatters: _digitsOnly,
            ),
            right: AppTextField(
              controller: _workCost,
              label: 'Вартість робіт (грн)',
              dense: true,
              keyboardType: TextInputType.number,
              inputFormatters: _digitsOnly,
            ),
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _description,
            label: 'Опис робіт',
            hint: 'Що було зроблено...',
            dense: true,
            minLines: 3,
            maxLines: 4,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: FieldLabel('Замінені деталі (${_parts.length})')),
              TextButton.icon(
                onPressed: _addPart,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Додати'),
              ),
            ],
          ),
          _PartsLayout(
            name: const FieldLabel('Назва'),
            manufacturer: const FieldLabel('Виробник'),
            quantity: const FieldLabel('К-ть'),
            price: const FieldLabel('Ціна'),
            trailing: const SizedBox.shrink(),
          ),
          const SizedBox(height: 6),
          for (final part in _parts)
            Padding(
              key: part.key,
              padding: const EdgeInsets.only(bottom: 8),
              child: _PartsLayout(
                name: AppTextField(
                  controller: part.name,
                  hint: 'Назва',
                  dense: true,
                ),
                manufacturer: AppTextField(
                  controller: part.manufacturer,
                  dense: true,
                ),
                quantity: AppTextField(
                  controller: part.quantity,
                  dense: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: _digitsOnly,
                ),
                price: AppTextField(
                  controller: part.price,
                  dense: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: _digitsOnly,
                ),
                trailing: IconButton(
                  tooltip: 'Видалити деталь',
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => _removePart(part),
                ),
              ),
            ),
          const SizedBox(height: 4),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 14),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Загальна вартість',
                  style: AppTextStyles.sectionTitle,
                ),
              ),
              Text(
                formatUah(_totalCost),
                style: AppTextStyles.sectionTitle.copyWith(
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
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
                label: 'Зберегти запис',
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

/// Однакова сітка колонок для заголовка та рядків таблиці деталей.
class _PartsLayout extends StatelessWidget {
  const _PartsLayout({
    required this.name,
    required this.manufacturer,
    required this.quantity,
    required this.price,
    required this.trailing,
  });

  final Widget name;
  final Widget manufacturer;
  final Widget quantity;
  final Widget price;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 420;
        final qtyWidth = compact ? 44.0 : 52.0;
        final priceWidth = compact ? 58.0 : 72.0;
        final trailingWidth = compact ? 36.0 : 40.0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 5, child: name),
            const SizedBox(width: 8),
            Expanded(flex: 3, child: manufacturer),
            const SizedBox(width: 8),
            SizedBox(width: qtyWidth, child: quantity),
            const SizedBox(width: 8),
            SizedBox(width: priceWidth, child: price),
            SizedBox(width: trailingWidth, child: trailing),
          ],
        );
      },
    );
  }
}
