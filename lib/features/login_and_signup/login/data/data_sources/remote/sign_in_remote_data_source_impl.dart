import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/config/api_calls/safe_api_call.dart';
import 'package:exam_app_elevate/features/login_and_signup/login/data/api_client/auth_api_client.dart';
import 'package:exam_app_elevate/features/login_and_signup/login/data/data_sources/remote/sign_in_remote_data_source.dart';
import 'package:exam_app_elevate/features/login_and_signup/login/data/models/sign_in_request.dart';
import 'package:exam_app_elevate/features/login_and_signup/models/auth_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignInRemoteDataSource)
class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  final AuthApiClient _authApiClient;

  SignInRemoteDataSourceImpl(this._authApiClient);

  @override
  Future<BaseResponse<AuthResponseModel>> signIn({
    required SignInRequest request,
  }) {
    return safeApiCall(() => _authApiClient.signIn(request));
  }
}
