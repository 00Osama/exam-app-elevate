import 'package:exam_app_elevate/config/di/di.dart';
import 'package:exam_app_elevate/core/constants/app_strings.dart';
import 'package:exam_app_elevate/core/theme/app_colors.dart';
import 'package:exam_app_elevate/core/utils/validators.dart';
import 'package:exam_app_elevate/features/auth/sign_up/presentation/view_model/sign_up_cubit.dart';
import 'package:exam_app_elevate/features/auth/sign_up/presentation/view_model/sign_up_events.dart';
import 'package:exam_app_elevate/features/auth/sign_up/presentation/view_model/sign_up_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final hidePassword = ValueNotifier<bool>(true);
  final hideRePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    hidePassword.dispose();
    hideRePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpViewModel>(
      create: (context) => getIt<SignUpViewModel>(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.signUp),
            centerTitle: true,
          ),
          body: BlocListener<SignUpViewModel, SignUpState>(
            listenWhen: (previous, current) =>
                previous.signUpState != current.signUpState,
            listener: (context, state) {
              if (state.signUpState.data != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppStrings.accountCreated)),
                );
                Navigator.pop(context);
              }
              if (state.signUpState.errMsg != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.signUpState.errMsg!)),
                );
              }
            },
            child: SafeArea(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () => context.read<SignUpViewModel>().onEvent(
                  SignUpFormChangedEvent(
                    username: usernameController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    rePassword: rePasswordController.text,
                    phone: phoneController.text,
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  children: [
                    TextFormField(
                      controller: usernameController,
                      textInputAction: TextInputAction.next,
                      validator: AppValidators.username,
                      decoration: const InputDecoration(
                        labelText: AppStrings.userName,
                        hintText: AppStrings.enterYourUserName,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: firstNameController,
                            textInputAction: TextInputAction.next,
                            validator: AppValidators.name,
                            decoration: const InputDecoration(
                              labelText: AppStrings.firstName,
                              hintText: AppStrings.enterFirstName,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: lastNameController,
                            textInputAction: TextInputAction.next,
                            validator: AppValidators.name,
                            decoration: const InputDecoration(
                              labelText: AppStrings.lastName,
                              hintText: AppStrings.enterLastName,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: AppValidators.email,
                      decoration: const InputDecoration(
                        labelText: AppStrings.email,
                        hintText: AppStrings.enterYourEmail,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: hidePassword,
                            builder: (context, isHidden, child) {
                              return TextFormField(
                                controller: passwordController,
                                obscureText: isHidden,
                                textInputAction: TextInputAction.next,
                                validator: AppValidators.password,
                                decoration: InputDecoration(
                                  labelText: AppStrings.password,
                                  hintText: AppStrings.enterPassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () => hidePassword.value =
                                        !hidePassword.value,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: hideRePassword,
                            builder: (context, isHidden, child) {
                              return TextFormField(
                                controller: rePasswordController,
                                obscureText: isHidden,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    AppValidators.confirmPassword(
                                      value,
                                      passwordController.text,
                                    ),
                                decoration: InputDecoration(
                                  labelText: AppStrings.confirmPassword,
                                  hintText: AppStrings.confirmPassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () => hideRePassword.value =
                                        !hideRePassword.value,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      validator: AppValidators.phone,
                      decoration: const InputDecoration(
                        labelText: AppStrings.phoneNumber,
                        hintText: AppStrings.enterPhoneNumber,
                      ),
                    ),
                    const SizedBox(height: 48),

                    BlocBuilder<SignUpViewModel, SignUpState>(
                      buildWhen: (previous, current) =>
                          previous.isFormValid != current.isFormValid ||
                          previous.signUpState.isLoading !=
                              current.signUpState.isLoading,
                      builder: (context, state) {
                        final bool isLoading = state.signUpState.isLoading;

                        return ElevatedButton(
                          onPressed: (!state.isFormValid || isLoading)
                              ? null
                              : () => context.read<SignUpViewModel>().onEvent(
                                  SignUpEvent(
                                    username: usernameController.text.trim(),
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                    rePassword: rePasswordController.text,
                                    phone: phoneController.text.trim(),
                                  ),
                                ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary,
                                  ),
                                )
                              : const Text(AppStrings.signUp),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.alreadyHaveAccount,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          child: const Text(AppStrings.login),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
