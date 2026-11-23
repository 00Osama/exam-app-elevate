import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/features/forget_password/domain/repos/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SendEmailUseCase {
  final ForgetPasswordRepository repository;

  SendEmailUseCase(this.repository);

  Future<BaseResponse<void>> sendEmail(String email) {
    return repository.sendEmailForResetPassword(email);
  }
}
