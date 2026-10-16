import 'package:flutter/material.dart';

import '../../data/models/record_type.dart';
import '../theme/app_colors.dart';

Color recordTypeColor(RecordType type) {
  switch (type) {
    case RecordType.maintenance:
      return AppColors.primary;
    case RecordType.repair:
      return AppColors.warning;
    case RecordType.diagnostics:
      return AppColors.info;
  }
}

Color recordTypeSoftColor(RecordType type) {
  switch (type) {
    case RecordType.maintenance:
      return AppColors.primarySoft;
    case RecordType.repair:
      return AppColors.warningSoft;
    case RecordType.diagnostics:
      return AppColors.infoSoft;
  }
}

class TypeBadge extends StatelessWidget {
  const TypeBadge({super.key, required this.type});

  final RecordType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: recordTypeSoftColor(type),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        type.label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: recordTypeColor(type),
        ),
      ),
    );
  }
}
