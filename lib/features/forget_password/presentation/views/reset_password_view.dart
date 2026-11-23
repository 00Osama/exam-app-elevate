import 'package:exam_app_elevate/core/extensions/view_width_and_heigth.dart';
import 'package:exam_app_elevate/core/widgets/back_button.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/view_model/forget_password_states.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? passwordError;
  String? confirmPasswordError;
  bool obscurePassword = true;
  bool obscureConfirmation = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        title: Text(
          'Reset Password',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
        listener: (context, state) {
          if (state.state.errMsg != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.state.errMsg!)));
          }
        },
        builder: (context, state) {
          final isLoading = state.state.isLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Text(
                    'Reset password',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Password must contain at least 6 characters, one uppercase letter, and one number',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      enabled: !isLoading,
                      onChanged: (_) {
                        if (passwordError != null) {
                          setState(() => passwordError = null);
                        }
                      },
                      decoration: InputDecoration(
                        errorText: passwordError,
                        labelText: 'New Password',
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            obscurePassword = !obscurePassword;
                          }),
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: obscureConfirmation,
                      enabled: !isLoading,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(context),
                      onChanged: (_) {
                        if (confirmPasswordError != null) {
                          setState(() => confirmPasswordError = null);
                        }
                      },
                      decoration: InputDecoration(
                        errorText: confirmPasswordError,
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            obscureConfirmation = !obscureConfirmation;
                          }),
                          icon: Icon(
                            obscureConfirmation
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: context.viewWidth * 0.9,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _submit(context),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit(BuildContext context) {
    final password = passwordController.text;
    final confirmation = confirmPasswordController.text;

    final passwordValid =
        password.length >= 6 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]'));

    setState(() {
      passwordError = passwordValid
          ? null
          : 'Password must contain 6 characters, uppercase letter and number';
      confirmPasswordError = confirmation == password
          ? null
          : 'Passwords do not match';
    });

    if (!passwordValid || confirmation != password) return;

    FocusScope.of(context).unfocus();
    context.read<ForgetPasswordViewModel>().resetPassword(password);
  }
}
