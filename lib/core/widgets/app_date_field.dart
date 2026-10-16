import 'package:flutter/material.dart';

import '../utils/formatters.dart';
import 'app_text_field.dart';

class AppDateField extends StatefulWidget {
  const AppDateField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.dense = true,
  });

  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final String? label;
  final bool dense;

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value == null ? '' : formatDate(widget.value!),
  );

  @override
  void didUpdateWidget(covariant AppDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.text = widget.value == null ? '' : formatDate(widget.value!);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.value ?? now,
      firstDate: DateTime(1990),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) widget.onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      label: widget.label,
      hint: 'дд.мм.рррр',
      suffixIcon: Icons.calendar_today_outlined,
      readOnly: true,
      dense: widget.dense,
      onTap: _pick,
    );
  }
}
