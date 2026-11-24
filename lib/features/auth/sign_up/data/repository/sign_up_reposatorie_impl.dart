import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/models/auth_response_model.dart';
import 'package:exam_app_elevate/features/auth/sign_up/data/data_source/remote/sign_up_remote_data_source.dart';
import 'package:exam_app_elevate/features/auth/sign_up/data/models/sign_up_request.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/entity/sign_up_param.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/repository/sign_up_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignUpRepository)
class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource _signUpRemoteDataSource;
  SignUpRepositoryImpl(this._signUpRemoteDataSource);
  @override
  Future<BaseResponse<AuthEntity>> signUp({
    required SignUpParams params
  }) async {
    final SignUpRequest request = params.toRequest();

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
