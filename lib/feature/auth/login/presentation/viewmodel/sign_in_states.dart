import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';

sealed class SignInStates {
  // Every state knows if the form is valid, so the button can use it
  final bool isFormValid;
  const SignInStates({this.isFormValid = false});
}

// Initial state, nothing is happening yet
class InitialSignInState extends SignInStates {
  const InitialSignInState();
}

// The user changed a field and the form validity changed
class FormChangedSignInState extends SignInStates {
  const FormChangedSignInState({required super.isFormValid});
}

class LoadingSignInState extends SignInStates {
  const LoadingSignInState({required super.isFormValid});
}

class SuccessSignInState extends SignInStates {
  final SignInEntity signInEntity;

  const SuccessSignInState({
    required this.signInEntity,
    required super.isFormValid,
  });
}

class ErrorSignInState extends SignInStates {
  final String errMsg;

  const ErrorSignInState({
    required this.errMsg,
    required super.isFormValid,
  });
}