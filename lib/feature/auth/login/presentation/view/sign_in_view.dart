import 'package:exam_app_elevate/Config/Di/di.dart';
import 'package:exam_app_elevate/core/constants/app_strings.dart';
import 'package:exam_app_elevate/core/theme/app_colors.dart';
import 'package:exam_app_elevate/core/utils/validators.dart';
import 'package:exam_app_elevate/feature/auth/login/presentation/viewmodel/sign_in_cubit.dart';
import 'package:exam_app_elevate/feature/auth/login/presentation/viewmodel/sign_in_events.dart';
import 'package:exam_app_elevate/feature/auth/login/presentation/viewmodel/sign_in_states.dart';
import 'package:exam_app_elevate/feature/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // Created here so the whole screen can use it
  late final SignInViewModel viewModel = getIt<SignInViewModel>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final hidePassword = ValueNotifier<bool>(true);
  final rememberMe = ValueNotifier<bool>(false);

  // Free everything when the screen is closed
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    hidePassword.dispose();
    rememberMe.dispose();
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInViewModel>.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.login), centerTitle: true),
        // Listens to state changes
        body: BlocListener<SignInViewModel, SignInState>(
          // Listen only when the sign in API state changes
          listenWhen: (previous, current) =>
              previous.signInState != current.signInState,
          listener: (context, state) {
            if (state.signInState.data != null) {
              // Temporary navigation, will be replaced with go_router later
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomeView()),
              );
            }
            if (state.signInState.errMsg != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.signInState.errMsg!)),
              );
            }
          },
          child: SafeArea(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // Tell the view model to check the fields on every change
              onChanged: () => viewModel.onEvent(
                FormChangedEvent(
                  email: emailController.text,
                  password: passwordController.text,
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                children: [
                  // Email
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                    decoration: const InputDecoration(
                      labelText: AppStrings.email,
                      hintText: AppStrings.enterYourEmail,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Password, only this field rebuilds when the eye icon is pressed
                  ValueListenableBuilder<bool>(
                    valueListenable: hidePassword,
                    builder: (context, isHidden, child) {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: isHidden,
                        textInputAction: TextInputAction.done,
                        validator: Validators.password,
                        decoration: InputDecoration(
                          labelText: AppStrings.password,
                          hintText: AppStrings.enterYourPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () =>
                                hidePassword.value = !hidePassword.value,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Remember me and forget password
                  Row(
                    children: [
                      // Only the checkbox rebuilds when it is pressed
                      ValueListenableBuilder<bool>(
                        valueListenable: rememberMe,
                        builder: (context, isChecked, child) {
                          return Checkbox(
                            value: isChecked,
                            onChanged: (value) =>
                                rememberMe.value = value ?? false,
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.rememberMe,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // TODO: go to forget password
                        },
                        child: const Text(AppStrings.forgetPassword),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),

                  // Login button
                  BlocBuilder<SignInViewModel, SignInState>(
                    // Rebuild only when the form validity or the loading changes
                    buildWhen: (previous, current) =>
                        previous.isFormValid != current.isFormValid ||
                        previous.signInState.isLoading !=
                            current.signInState.isLoading,
                    builder: (context, state) {
                      final bool isLoading = state.signInState.isLoading;

                      return ElevatedButton(
                        // Enabled only when the form is valid and not loading
                        onPressed: (!state.isFormValid || isLoading)
                            ? null
                            : () => viewModel.onEvent(
                                SignInEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                  rememberMe: rememberMe.value,
                                ),
                              ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : const Text(AppStrings.login),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Don't have an account? Sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAccount,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: go to sign up
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        child: const Text(AppStrings.signUp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
