import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.size = 44, this.rounded = false});

  final double size;

  /// false – коло, true – квадрат із закругленнями (як у профілі).
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.tile,
        shape: rounded ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: rounded ? BorderRadius.circular(size * 0.22) : null,
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(
        Icons.person_outline,
        size: size * 0.5,
        color: AppColors.textHint,
      ),
    );
  }
}
