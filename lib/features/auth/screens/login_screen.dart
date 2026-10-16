import 'package:flutter/material.dart';

import '../../../core/router/app_navigator.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_link.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/or_divider.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../widgets/auth_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() => AppNavigator.enterApp(context);

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'TechBook',
            textAlign: TextAlign.center,
            style: AppTextStyles.logo,
          ),
          const SizedBox(height: 4),
          const Text(
            'Увійдіть до облікового запису',
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 36),
          AppTextField(
            controller: _emailController,
            hint: 'Електронна пошта',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: _passwordController,
            hint: 'Пароль',
            isPassword: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 16),
          PrimaryButton(label: 'Увійти', onPressed: _submit),
          const SizedBox(height: 8),
          Center(
            child: AppLink(
              label: 'Забули пароль?',
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
            ),
          ),
          const SizedBox(height: 8),
          const OrDivider(),
          const SizedBox(height: 16),
          SecondaryButton(
            label: 'Створити обліковий запис',
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.register),
          ),
        ],
      ),
    );
  }
}
