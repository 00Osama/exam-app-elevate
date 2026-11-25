import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/login_and_signup/models/auth_response_model.dart';
import 'package:exam_app_elevate/features/login_and_signup/sign_up/data/models/sign_up_request.dart';

abstract interface class SignUpRemoteDataSource {
  Future<BaseResponse<AuthResponseModel>> signUp({
    required SignUpRequest request,
  });
}
