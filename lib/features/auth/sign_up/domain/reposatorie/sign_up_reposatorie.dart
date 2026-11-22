import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';

abstract interface class SignUpReposatorie {
  Future<BaseResponse<AuthEntity>> signUp({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  });

}