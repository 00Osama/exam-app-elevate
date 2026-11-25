import 'package:exam_app_elevate/config/api_calls/safe_api_call.dart';
import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/login_and_signup/models/auth_response_model.dart';
import 'package:exam_app_elevate/features/login_and_signup/sign_up/data/data_source/remote/sign_up_remote_data_source.dart';
import 'package:exam_app_elevate/features/login_and_signup/sign_up/data/models/sign_up_request.dart';
import 'package:exam_app_elevate/features/login_and_signup/sign_up/data/sign_up_api_client/sign_up_api_client.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final SignUpApiClient _signUpApiClient;

  SignUpRemoteDataSourceImpl(this._signUpApiClient);

  @override
  Future<BaseResponse<AuthResponseModel>> signUp({
    required SignUpRequest request,
  }) {
    return safeApiCall<AuthResponseModel>(
      () => _signUpApiClient.signUp(request),
    );
  }
}
