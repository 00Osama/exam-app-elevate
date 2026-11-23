import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/features/forget_password/data/data_source/interface/remote/remote_data_source.dart';
import 'package:exam_app_elevate/features/forget_password/domain/repos/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPasswordRepository)
class ForgetPasswordRepoImpl implements ForgetPasswordRepository {
  final RemoteDataSource remoteDataSource;

  ForgetPasswordRepoImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<void>> sendEmailForResetPassword(String email) async {
    final response = await remoteDataSource.sendEmailForResetPassword(email);
    switch (response) {
      case SuccessBaseResponse<void>():
        return SuccessBaseResponse<void>(data: null);
      case ErrorBaseResponse<void>():
        return ErrorBaseResponse<void>.fromErrorMsg(
          response.toString(),
        );
    }
  }

  @override
  Future<BaseResponse<void>> resetPassword(String password) async {
    final response = await remoteDataSource.resetPassword(password);
    switch (response) {
      case SuccessBaseResponse<void>():
        return SuccessBaseResponse<void>(data: null);
      case ErrorBaseResponse<void>():
        return ErrorBaseResponse<void>.fromErrorMsg(
          response.toString(),
        );
    }
  }
}
