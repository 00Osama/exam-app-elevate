import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/login_and_signup/login/data/models/sign_in_request.dart';
import 'package:exam_app_elevate/features/login_and_signup/models/auth_response_model.dart';

abstract interface class SignInRemoteDataSource {
  Future<BaseResponse<AuthResponseModel>> signIn({
    required SignInRequest request,
  });
}
