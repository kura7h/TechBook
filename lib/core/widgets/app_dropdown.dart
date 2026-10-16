import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_input_decoration.dart';
import 'field_label.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.dense = false,
  });

  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? label;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final decoration = AppInputDecoration.build(dense: dense).copyWith(
      contentPadding: EdgeInsets.symmetric(
        horizontal: dense ? 14 : 16,
        vertical: dense ? 0 : 4,
      ),
    );

    final field = InputDecorator(
      decoration: decoration,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          borderRadius: BorderRadius.circular(14),
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textPrimary,
          ),
          style: TextStyle(
            fontSize: dense ? 14 : 16,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );

    if (label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FieldLabel(label!),
        const SizedBox(height: 6),
        field,
      ],
    );
  }
}
