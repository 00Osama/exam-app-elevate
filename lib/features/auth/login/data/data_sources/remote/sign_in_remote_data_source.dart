import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/login/data/models/sign_in_request.dart';
import 'package:exam_app_elevate/features/auth/models/auth_response_model.dart';

abstract interface class SignInRemoteDataSource {
  Future<BaseResponse<AuthResponseModel>> signIn({required SignInRequest request});
  // Future<SignUpResponse> signUp(SignUpRequest request);
}