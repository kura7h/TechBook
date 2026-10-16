import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

/// Підпис поля великими літерами (ІМ'Я ТА ПРІЗВИЩЕ, EMAIL ...).
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: AppTextStyles.fieldLabel);
  }
}
