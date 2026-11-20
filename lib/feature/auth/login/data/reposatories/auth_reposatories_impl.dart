import 'dart:developer';

import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/feature/auth/login/data/datasources/local/sign_in_local_data_source.dart';
import 'package:exam_app_elevate/feature/auth/login/data/datasources/remote/sign_in_remote_data_source.dart';
import 'package:exam_app_elevate/feature/auth/login/data/models/sign_in_request.dart';
import 'package:exam_app_elevate/feature/auth/login/data/models/sign_in_response.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/reposatories/sign_in_reposatories.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthReposatories)
class AuthReposatoriesImpl implements AuthReposatories {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthReposatoriesImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<BaseResponse<SignInEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    // 1- make request
    final SignInRequest request = SignInRequest(
      email: email,
      password: password,
    );

    // 2- take the response from data source
    final BaseResponse<SignInResponse> response = await _authRemoteDataSource
        .signIn(request: request);
    //3- save token and remember me
    if (response is SuccessBaseResponse<SignInResponse>) {
        log("SignIn called", name: "signInRepo");
      final String? token = response.data.token;
      if (token != null) {
        await _authLocalDataSource.saveToken(token);
        await _authLocalDataSource.saveRememberMe(rememberMe);
      }
    }
    //4-convert to entity if success / convert error message if error
    return switch (response) {
      SuccessBaseResponse<SignInResponse>(:final data) =>
        // 5- convert model to entity
        SuccessBaseResponse<SignInEntity>(data: data.toDomain()),
      ErrorBaseResponse<SignInResponse>(:final errMessage) =>
        ErrorBaseResponse<SignInEntity>.fromErrorMsg(errMessage),
    };
  }

@override
Future<bool> isLoggedIn() async {
  try {
    // 1- get remember me and token
    final bool rememberMe = await _authLocalDataSource.getRememberMe();
    final String? token = await _authLocalDataSource.getToken();

    // 2- token not null and remember me = true => logged in => go to home
    if (token != null && rememberMe) {
      return true;
    }

    // 3- otherwise clear storage => go to login
    await _authLocalDataSource.clear();
    return false;
  } catch (e) {
    log('isLoggedIn failed: $e', name: 'AuthRepository');
    return false;
  }
}
  }
