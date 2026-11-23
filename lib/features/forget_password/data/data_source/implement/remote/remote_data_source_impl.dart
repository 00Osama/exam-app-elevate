import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/features/forget_password/api/api_client.dart';
import 'package:exam_app_elevate/features/forget_password/data/data_source/interface/remote/remote_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl(this.apiClient);

  final AuthApiClient apiClient;

  @override
  Future<BaseResponse<void>> sendEmailForResetPassword(String email) async {
    try {
      await apiClient.sendEmailForResetPassword(email);
      return SuccessBaseResponse<void>(data: null);
    } on Exception catch (e) {
      return ErrorBaseResponse<void>(errorObj: e);
    }
  }

  @override
  Future<BaseResponse<void>> resetPassword(String password) async {
    try {
      await apiClient.resetPassword(password);
      return SuccessBaseResponse<void>(data: null);
    } on Exception catch (e) {
      return ErrorBaseResponse<void>(errorObj: e);
    }
  }
}
