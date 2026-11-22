import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/models/auth_response_model.dart';
import 'package:exam_app_elevate/features/auth/sign_up/data/data_source/remote/sign_up_remote_data_source.dart';
import 'package:exam_app_elevate/features/auth/sign_up/data/models/sign_up_request.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/reposatorie/sign_up_reposatorie.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignUpReposatorie)
class SignUpReposatorieImpl implements SignUpReposatorie {
  final SignUpRemoteDataSource _signUpRemoteDataSource;
  SignUpReposatorieImpl(this._signUpRemoteDataSource);
  @override
  Future<BaseResponse<AuthEntity>> signUp({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    final SignUpRequest request = SignUpRequest(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );

    final BaseResponse<AuthResponseModel> response =
        await _signUpRemoteDataSource.signUp(request: request);

    return switch (response) {
      SuccessBaseResponse<AuthResponseModel>(data: final data) =>
        SuccessBaseResponse<AuthEntity>(data: data.toDomain()),
      ErrorBaseResponse<AuthResponseModel>(errMessage: final errMessage) =>
        ErrorBaseResponse<AuthEntity>.fromErrorMsg(errMessage),
    };
  }
}
