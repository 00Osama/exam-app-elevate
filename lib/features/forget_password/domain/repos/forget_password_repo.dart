import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';

abstract class ForgetPasswordRepository {
  Future<BaseResponse<void>> sendEmailForResetPassword(String email);
  Future<BaseResponse<void>> resetPassword(String password);
}
