import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';

sealed class LoginStates {}

//Initial state is an ideal state
class InitialLoginState extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {
  final SignInEntity signInEntity;
  SuccessLoginState({required this.signInEntity});
}

class ErrorLoginState extends LoginStates {
  String errMsg;

  ErrorLoginState({required this.errMsg});
}
