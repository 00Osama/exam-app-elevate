import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/feature/auth/login/data/models/sign_in_request.dart';
import 'package:exam_app_elevate/feature/auth/login/data/models/sign_in_response.dart';

abstract interface class SignInRemoteDataSource {
  Future<BaseResponse<SignInResponse>> signIn({required SignInRequest request});
  // Future<SignUpResponse> signUp(SignUpRequest request);
}