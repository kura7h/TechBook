import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_input_decoration.dart';
import 'field_label.dart';

/// Стилізоване текстове поле. Підтримує підпис, іконку, режим пароля
/// (з кнопкою "показати/сховати") та компактний режим для діалогів.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.dense = false,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? minLines;
  final bool readOnly;
  final bool dense;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    Widget? suffix;
    if (widget.isPassword) {
      suffix = IconButton(
        tooltip: _obscure ? 'Показати пароль' : 'Сховати пароль',
        icon: Icon(
          _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 22,
          color: AppColors.textSecondary,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      );
    } else if (widget.suffixIcon != null) {
      suffix = Icon(
        widget.suffixIcon,
        size: 20,
        color: AppColors.textSecondary,
      );
    }

    final field = TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscure,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      minLines: widget.isPassword ? 1 : widget.minLines,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      style: TextStyle(
        fontSize: widget.dense ? 14 : 16,
        color: AppColors.textPrimary,
      ),
      decoration: AppInputDecoration.build(
        hint: widget.hint,
        dense: widget.dense,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(widget.prefixIcon, size: 20, color: AppColors.textSecondary),
        suffixIcon: suffix,
      ),
    );

    if (widget.label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FieldLabel(widget.label!),
        const SizedBox(height: 6),
        field,
      ],
    );
  }
}
