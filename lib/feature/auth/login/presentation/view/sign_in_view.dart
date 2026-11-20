import 'package:exam_app_elevate/Config/Di/di.dart';
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
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool hidePassword = true;
  bool isFormValid = false;
  bool isSubmitted = false;

  // Free the controllers when the screen is closed
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInViewModel>(
      create: (context) => getIt<SignInViewModel>(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Login'), centerTitle: true),
          body: BlocConsumer<SignInViewModel, SignInStates>(
            listener: (context, state) {
              switch (state) {
                case InitialSignInState():
                case LoadingSignInState():
                  break; // nothing to do
                case SuccessSignInState():
                  // Temporary navigation, will be replaced with go_router later
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomeView()),
                  );
                  break;
                case ErrorSignInState():
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.errMsg)));
              }
            },

            builder: (context, state) {
              final bool isLoading = state is LoadingSignInState;

              return Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // Check the fields on every change to enable or disable the button
                onChanged: () {
                  final bool isValid =
                      Validators.email(emailController.text) == null &&
                      Validators.password(passwordController.text) == null;

                  if (isValid != isFormValid) {
                    setState(() => isFormValid = isValid);
                  }
                },
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
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      textInputAction: TextInputAction.done,
                      validator: Validators.password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() => hidePassword = !hidePassword);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Remember me and forget password
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() => rememberMe = value ?? false);
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Remember me',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // TODO: go to forget password
                          },
                          child: const Text('Forget password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),

                    // Login button, grey when the form is not valid or loading
                    ElevatedButton(
                      // Disabled while loading, or after a failed try until the form is valid
                      onPressed: (isLoading || (isSubmitted && !isFormValid))
                          ? null
                          : () {
                              setState(() => isSubmitted = true);

                              // Shows the errors under the fields if the data is not valid
                              if (!formKey.currentState!.validate()) return;

                              context.read<SignInViewModel>().onEvent(
                                SignInEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                  rememberMe: rememberMe,
                                ),
                              );
                            },
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.white,
                              ),
                            )
                          : const Text('Login'),
                    ),
                    const SizedBox(height: 16),

                    // Don't have an account? Sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
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
                          child: const Text('Sign up'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
