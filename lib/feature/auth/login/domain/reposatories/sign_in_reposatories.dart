import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';

abstract class AuthReposatories {
  Future<BaseResponse<SignInEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<bool> isLoggedIn();

}
