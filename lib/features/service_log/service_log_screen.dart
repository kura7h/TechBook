import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_dropdown.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/page_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/mock_data.dart';
import '../../data/models/record_type.dart';
import '../../data/models/service_record.dart';
import '../dashboard/add_service_record_dialog.dart';
import 'widgets/service_record_row.dart';

class ServiceLogScreen extends StatefulWidget {
  const ServiceLogScreen({super.key});

  @override
  State<ServiceLogScreen> createState() => _ServiceLogScreenState();
}

class _ServiceLogScreenState extends State<ServiceLogScreen> {
  final _searchController = TextEditingController();
  String? _carFilter;
  RecordType? _typeFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _addRecord() async {
    final record = await showDialog<ServiceRecord>(
      context: context,
      builder: (context) => AddServiceRecordDialog(initialCarId: _carFilter),
    );
    if (record != null && mounted) {
      setState(() => MockData.addServiceRecord(record));
    }
  }

  List<ServiceRecord> get _filtered {
    final query = _searchController.text.trim().toLowerCase();
    return MockData.recordsFor(carId: _carFilter).where((record) {
      final matchesType = _typeFilter == null || record.type == _typeFilter;
      final matchesQuery =
          query.isEmpty || record.description.toLowerCase().contains(query);
      return matchesType && matchesQuery;
    }).toList();
  }

  String _carName(String carId) => MockData.carById(carId)?.name ?? '—';

  @override
  Widget build(BuildContext context) {
    final records = _filtered;

    return PageScaffold(
      title: 'Журнал обслуговування',
      actions: [
        PrimaryButton(
          label: 'Додати запис',
          icon: Icons.add,
          expand: false,
          dense: true,
          onPressed: _addRecord,
        ),
      ],
      children: [
        _buildFilters(),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 760;

            return AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (wide) ...[
                    const ServiceTableHeader(),
                    const Divider(height: 1, color: AppColors.divider),
                  ],
                  if (records.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(
                        child: Text(
                          'Записів не знайдено',
                          style: AppTextStyles.caption,
                        ),
                      ),
                    )
                  else
                    for (var i = 0; i < records.length; i++) ...[
                      if (wide)
                        ServiceRecordRow(
                          record: records[i],
                          carName: _carName(records[i].carId),
                          onDelete: () => setState(
                            () => MockData.removeServiceRecord(records[i].id),
                          ),
                        )
                      else
                        ServiceRecordCompactTile(
                          record: records[i],
                          carName: _carName(records[i].carId),
                          onDelete: () => setState(
                            () => MockData.removeServiceRecord(records[i].id),
                          ),
                        ),
                      if (i != records.length - 1)
                        const Divider(height: 1, color: AppColors.divider),
                    ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilters() {
    final search = AppTextField(
      controller: _searchController,
      hint: 'Пошук за описом...',
      prefixIcon: Icons.search,
      onChanged: (_) => setState(() {}),
    );

    final carDropdown = AppDropdown<String?>(
      value: _carFilter,
      items: [
        const DropdownMenuItem<String?>(
          value: null,
          child: Text('Всі автомобілі'),
        ),
        for (final car in MockData.cars)
          DropdownMenuItem<String?>(
            value: car.id,
            child: Text(car.name, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: (value) => setState(() => _carFilter = value),
    );

    final typeDropdown = AppDropdown<RecordType?>(
      value: _typeFilter,
      items: [
        const DropdownMenuItem<RecordType?>(
          value: null,
          child: Text('Всі типи'),
        ),
        for (final type in RecordType.values)
          DropdownMenuItem<RecordType?>(
            value: type,
            child: Text(type.label),
          ),
      ],
      onChanged: (value) => setState(() => _typeFilter = value),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 760) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              search,
              const SizedBox(height: 12),
              carDropdown,
              const SizedBox(height: 12),
              typeDropdown,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: search),
            const SizedBox(width: 12),
            SizedBox(width: 210, child: carDropdown),
            const SizedBox(width: 12),
            SizedBox(width: 190, child: typeDropdown),
          ],
        );
      },
    );
  }
}
