import 'dart:developer';

import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/reposatories/sign_in_reposatories.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  final AuthReposatories _authReposatories;
  SignInUseCase(this._authReposatories);
Future<BaseResponse<SignInEntity>> call({
  required String email,
  required String password,
  required bool rememberMe,
}) {
    log("SignIn called", name: "signInUseCase");
    return _authReposatories.signIn(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
