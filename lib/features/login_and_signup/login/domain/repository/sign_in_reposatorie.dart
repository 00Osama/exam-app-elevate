import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/login_and_signup/entity/auth_entity.dart';

abstract interface class SignInRepository {
  Future<BaseResponse<AuthEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<bool> isLoggedIn();
}
