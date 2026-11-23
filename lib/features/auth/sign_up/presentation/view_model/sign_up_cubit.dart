import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/core/utils/validators.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/entity/sign_up_param.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:exam_app_elevate/features/auth/sign_up/presentation/view_model/sign_up_events.dart';
import 'package:exam_app_elevate/features/auth/sign_up/presentation/view_model/sign_up_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  SignUpViewModel(this._signUpUseCase) : super(const SignUpState());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

    // Builds the params from the current text field values.
  SignUpParams get params => SignUpParams(
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        rePassword: rePasswordController.text,
        phone: phoneController.text.trim(),
      );

  void onEvent(SignUpEvents event) {
    switch (event) {
      case SignUpEvent():
        _signUp();
      case SignUpFormChangedEvent():
        _onFormChanged();
    }
  }

  Future<void> _signUp() async {
    // Start loading.
    emit(
      state.copyWith(signUpState: state.signUpState.copyWith(isLoading: true)),
    );

    final BaseResponse<AuthEntity> apiResult = await _signUpUseCase(params);

    // Stop if the screen was closed 
    if (isClosed) return;

    switch (apiResult) {
      case SuccessBaseResponse<AuthEntity>():
        emit(
          state.copyWith(
            signUpState: state.signUpState.copyWith(
              isLoading: false,
              data: apiResult.data,
            ),
          ),
        );
      case ErrorBaseResponse<AuthEntity>():
        emit(
          state.copyWith(
            signUpState: state.signUpState.copyWith(
              isLoading: false,
              errMsg: apiResult.errMessage,
            ),
          ),
        );
    }
  }

  void _onFormChanged() {
    // Read the values once, then check every field.
    final SignUpParams current = params;

    final bool isValid =
        AppValidators.username(current.username) == null &&
        AppValidators.name(current.firstName) == null &&
        AppValidators.name(current.lastName) == null &&
        AppValidators.email(current.email) == null &&
        AppValidators.password(current.password) == null &&
        AppValidators.confirmPassword(current.rePassword, current.password) ==
            null &&
        AppValidators.phone(current.phone) == null;

    emit(state.copyWith(isFormValid: isValid));
  }

  @override
  Future<void> close() {
    // Dispose controllers to avoid memory leaks.
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}