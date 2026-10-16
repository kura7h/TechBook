import 'package:flutter/material.dart';

/// Два поля в одному рядку з однаковою шириною.
class FieldRow extends StatelessWidget {
  const FieldRow({
    super.key,
    required this.left,
    required this.right,
    this.gap = 16,
  });

  final Widget left;
  final Widget right;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        SizedBox(width: gap),
        Expanded(child: right),
      ],
    );
  }
}
