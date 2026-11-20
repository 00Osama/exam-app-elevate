import 'dart:developer';

import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/feature/auth/login/data/apiclient/auth_api_client.dart';
import 'package:exam_app_elevate/feature/auth/login/data/datasources/remote/sign_in_remote_data_source.dart';
import 'package:exam_app_elevate/feature/auth/login/data/models/sign_in_request.dart';
import 'package:exam_app_elevate/feature/auth/login/data/models/sign_in_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final AuthApiClient _authApiClient;

  AuthRemoteDataSourceImpl(this._authApiClient);

  @override
  Future<BaseResponse<SignInResponse>> signIn({
    required SignInRequest request,
  }) async {
    log('signIn called', name: 'AuthRemoteDataSource');
    try {
      final SignInResponse response = await _authApiClient.signIn(request);
      log('signIn success: ${response.message}', name: 'AuthRemoteDataSource');
      return SuccessBaseResponse<SignInResponse>(data: response);
    } catch (e) {
      log('signIn failed: $e', name: 'AuthRemoteDataSource');
      return ErrorBaseResponse<SignInResponse>(errorObj: e);
    }
  }
}