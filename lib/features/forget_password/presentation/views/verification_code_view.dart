import 'package:exam_app_elevate/core/extensions/view_width_and_heigth.dart';
import 'package:exam_app_elevate/core/widgets/back_button.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/view_model/forget_password_states.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/views/reset_password_view.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/widgets/verification_code_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCodeView extends StatefulWidget {
  const VerificationCodeView({super.key});

  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView> {
  String code = '';
  String? codeError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        title: Text('Password', style: Theme.of(context).textTheme.bodyMedium),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Text(
                'Verification Code',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Please enter the verification code sent to your email',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: VerificationCodeInput(
                  onChanged: (value) {
                    setState(() {
                      code = value;
                      codeError = null;
                    });
                  },
                ),
              ),
              if (codeError != null) ...[
                const SizedBox(height: 8),
                Text(codeError!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 50),
              BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                builder: (context, state) {
                  return SizedBox(
                    width: context.viewWidth * 0.9,
                    child: ElevatedButton(
                      onPressed: state.state.isLoading
                          ? null
                          : () {
                              if (code.length != 4) {
                                setState(() {
                                  codeError = 'Enter the 4-digit code';
                                });
                                return;
                              }

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context
                                        .read<ForgetPasswordViewModel>(),
                                    child: const ResetPasswordView(),
                                  ),
                                ),
                              );
                            },
                      child: const Text('Continue'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
