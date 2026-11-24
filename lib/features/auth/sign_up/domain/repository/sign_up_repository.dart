import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/entity/sign_up_param.dart';

abstract interface class SignUpRepository {
  Future<BaseResponse<AuthEntity>> signUp({required SignUpParams params});
}
