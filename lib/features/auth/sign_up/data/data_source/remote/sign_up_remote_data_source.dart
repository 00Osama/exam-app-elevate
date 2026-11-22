import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/models/auth_response_model.dart';
import 'package:exam_app_elevate/features/auth/sign_up/data/models/sign_up_request.dart';

abstract interface class SignUpRemoteDataSource {
  Future<BaseResponse<AuthResponseModel>> signUp({
    required SignUpRequest request,
  });
}
