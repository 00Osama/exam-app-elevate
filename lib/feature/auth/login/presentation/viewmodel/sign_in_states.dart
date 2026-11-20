import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';

sealed class SignInStates {}

//Initial state is an ideal state
class InitialSignInState extends SignInStates {}

class LoadingSignInState extends SignInStates {}

class SuccessSignInState extends SignInStates {
  final SignInEntity signInEntity;
  SuccessSignInState({required this.signInEntity});
}

class ErrorSignInState extends SignInStates {
  String errMsg;

  ErrorSignInState({required this.errMsg});
}
