// ignore: deprecated_member_use
import 'package:exam_app_elevate/Config/Di/di.dart';
import 'package:exam_app_elevate/core/extensions/email_extension.dart';
import 'package:exam_app_elevate/core/extensions/view_width_and_heigth.dart';
import 'package:exam_app_elevate/core/widgets/back_button.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/view_model/forget_password_states.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/view_model/forget_password_view_model.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/views/verification_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController emailController = TextEditingController();
  String? emailError;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        title: Text('Password', style: Theme.of(context).textTheme.bodyMedium),
      ),
      body: BlocProvider(
        create: (_) => getIt<ForgetPasswordViewModel>(),
        child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
          listener: (context, state) {
            if (state.state.errMsg != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.state.errMsg!)));
            }

            if (state.state.errMsg != null && state.state.isLoading == false) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<ForgetPasswordViewModel>(),
                    child: const VerificationCodeView(),
                  ),
                ),
              );
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
                      'Forget Password',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Please enter your email associated to your account',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 35),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        enabled: !isLoading,
                        onChanged: (_) {
                          if (emailError != null) {
                            setState(() => emailError = null);
                          }
                        },
                        onSubmitted: (_) => _continue(context),
                        decoration: InputDecoration(
                          errorText: emailError,
                          labelText: 'Email',
                          hintText: 'Enter your email',
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: context.viewWidth * 0.9,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () => _continue(context),
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
      ),
    );
  }

  void _continue(BuildContext context) {
    final email = emailController.text.trim();

    if (!email.isValidEmail) {
      setState(() => emailError = 'This Email is not valid');
      return;
    }

    setState(() => emailError = null);
    FocusScope.of(context).unfocus();
    context.read<ForgetPasswordViewModel>().sendEmail(email);
  }
}
