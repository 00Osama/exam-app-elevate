import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/features/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:exam_app_elevate/features/forget_password/domain/use_cases/send_email_use_case.dart';
import 'package:exam_app_elevate/features/forget_password/presentation/view_model/forget_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  ForgetPasswordViewModel(this.sendEmailUseCase, this.resetPasswordUseCase)
    : super(ForgetPasswordState());

  final SendEmailUseCase sendEmailUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  void sendEmail(String email) async {
    emit(
      state.copyWith(
        state: state.state.copyWith(isLoading: true, errMsg: null),
      ),
    );

    final response = await sendEmailUseCase.sendEmail(email);

    switch (response) {
      case SuccessBaseResponse<void>():
        emit(
          state.copyWith(
            state: state.state.copyWith(isLoading: false, errMsg: null),
          ),
        );
        break;
      case ErrorBaseResponse<void>():
        emit(
          state.copyWith(
            state: state.state.copyWith(
              isLoading: false,
              errMsg: response.errMessage,
            ),
          ),
        );
        break;
    }
  }

  void resetPassword(String newPassword) async {
    emit(
      state.copyWith(
        state: state.state.copyWith(isLoading: true, errMsg: null),
      ),
    );
    final response = await resetPasswordUseCase.resetPassword(newPassword);

    switch (response) {
      case SuccessBaseResponse<void>():
        emit(
          state.copyWith(
            state: state.state.copyWith(isLoading: false, errMsg: null),
          ),
        );
        break;
      case ErrorBaseResponse<void>():
        emit(
          state.copyWith(
            state: state.state.copyWith(
              isLoading: false,
              errMsg: response.errMessage,
            ),
          ),
        );
        break;
    }
  }
}
