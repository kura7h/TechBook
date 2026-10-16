import 'package:flutter/material.dart';

import '../../../core/router/app_navigator.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_link.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/auth_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() => AppNavigator.enterApp(context);

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Реєстрація', style: AppTextStyles.authTitle),
          const SizedBox(height: 4),
          const Text('Створіть обліковий запис', style: AppTextStyles.subtitle),
          const SizedBox(height: 32),
          AppTextField(
            controller: _nameController,
            hint: "Ім'я",
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
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
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: _confirmController,
            hint: 'Повторіть пароль',
            isPassword: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 20),
          PrimaryButton(label: 'Зареєструватися', onPressed: _submit),
          const SizedBox(height: 12),
          Center(
            child: AppLink(
              label: 'Вже маєте обліковий запис? Увійти',
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login),
            ),
          ),
        ],
      ),
    );
  }
}
