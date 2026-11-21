import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/login/domain/entity/sign_in_entity.dart';

abstract interface class SignInReposatorie {
  Future<BaseResponse<SignInEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<bool> isLoggedIn();

}
