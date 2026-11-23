import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';

abstract interface class SignInReposatory {
  Future<BaseResponse<AuthEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<bool> isLoggedIn();

}
