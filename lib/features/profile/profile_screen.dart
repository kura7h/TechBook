import 'package:flutter/material.dart';

import '../../core/layout/app_shell.dart';
import '../../core/router/app_navigator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/page_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';
import '../../core/widgets/user_avatar.dart';
import '../../data/mock_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _name =
      TextEditingController(text: MockData.user.fullName);
  late final TextEditingController _email =
      TextEditingController(text: MockData.user.email);
  late final TextEditingController _phone =
      TextEditingController(text: MockData.user.phone);
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(behavior: SnackBarBehavior.floating, content: Text(text)),
    );
  }

  void _save() {
    _currentPassword.clear();
    _newPassword.clear();
    _confirmPassword.clear();
    _showMessage('Зміни збережено');
  }

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < AppShell.wideBreakpoint;

    return PageScaffold(
      title: 'Профіль',
      maxWidth: 720,
      alignment: Alignment.topLeft,
      children: [
        AppCard(
          padding: const EdgeInsets.all(24),
          radius: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Фото профілю', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => _showMessage(
                      'Завантаження фото буде підключено на наступному етапі',
                    ),
                    child: const UserAvatar(size: 96, rounded: true),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Завантажте власне фото (JPG, PNG до 5MB)',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 12),
                        SecondaryButton(
                          label: 'Обрати фото',
                          icon: Icons.upload_outlined,
                          expand: false,
                          dense: true,
                          onPressed: () => _showMessage(
                            'Завантаження фото буде підключено на наступному етапі',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        AppCard(
          padding: const EdgeInsets.all(24),
          radius: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Персональні дані', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 20),
              AppTextField(
                controller: _name,
                label: "Ім'я та прізвище",
                prefixIcon: Icons.person_outline,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 18),
              AppTextField(
                controller: _email,
                label: 'Email',
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),
              AppTextField(
                controller: _phone,
                label: 'Телефон',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        AppCard(
          padding: const EdgeInsets.all(24),
          radius: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Зміна пароля', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 20),
              AppTextField(
                controller: _currentPassword,
                label: 'Поточний пароль',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 18),
              AppTextField(
                controller: _newPassword,
                label: 'Новий пароль',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 18),
              AppTextField(
                controller: _confirmPassword,
                label: 'Підтвердіть новий пароль',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: PrimaryButton(
            label: 'Зберегти зміни',
            expand: false,
            onPressed: _save,
          ),
        ),
        if (narrow) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: SecondaryButton(
              label: 'Вийти',
              icon: Icons.logout,
              iconColor: AppColors.textSecondary,
              expand: false,
              onPressed: () => AppNavigator.logout(context),
            ),
          ),
        ],
        const SizedBox(height: 8),
      ],
    );
  }
}
