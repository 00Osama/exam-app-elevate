import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/feature/auth/login/data/apiclient/auth_api_client.dart';
import 'package:exam_app_elevate/feature/auth/login/data/datasources/remote/sign_in_remote_data_source.dart';
import 'package:exam_app_elevate/feature/auth/login/data/models/sign_in_request.dart';
import 'package:exam_app_elevate/feature/auth/login/data/models/sign_in_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignInRemoteDataSource)
class SignInRemoteDataSourceImpl implements SignInRemoteDataSource{
  final AuthApiClient _authApiClient;

  SignInRemoteDataSourceImpl(this._authApiClient);

  @override
  Future<BaseResponse<SignInResponse>> signIn({
    required SignInRequest request,
  }) async {
    try {
      final SignInResponse response = await _authApiClient.signIn(request);
      return SuccessBaseResponse<SignInResponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<SignInResponse>(errorObj: e);
    }
  }
}