import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/core/utils/validators.dart';
import 'package:exam_app_elevate/features/login_and_signup/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/login_and_signup/sign_up/domain/entity/sign_up_param.dart';
import 'package:exam_app_elevate/features/login_and_signup/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:exam_app_elevate/features/login_and_signup/sign_up/presentation/view_model/sign_up_events.dart';
import 'package:exam_app_elevate/features/login_and_signup/sign_up/presentation/view_model/sign_up_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpViewModel(this._signUpUseCase) : super(const SignUpState());

  // The only entry point for the view
  void onEvent(SignUpEvents event) {
    switch (event) {
      case SignUpEvent():
        _signUp(event.params);
      case SignUpFormChangedEvent():
        _onFormChanged(event.params);
    }
  }

  // Checks all fields, Equatable stops the emit if nothing changed
  void _onFormChanged(SignUpParams params) {
    final bool isValid =
        AppValidators.username(params.username) == null &&
        AppValidators.name(params.firstName) == null &&
        AppValidators.name(params.lastName) == null &&
        AppValidators.email(params.email) == null &&
        AppValidators.password(params.password) == null &&
        AppValidators.confirmPassword(params.rePassword, params.password) ==
            null &&
        AppValidators.phone(params.phone) == null;

    emit(state.copyWith(isFormValid: isValid));
  }

  Future<void> _signUp(SignUpParams params) async {
    // Start loading, the old error is cleared
    emit(
      state.copyWith(signUpState: state.signUpState.copyWith(isLoading: true)),
    );

    final BaseResponse<AuthEntity> apiResult = await _signUpUseCase(params);

    // Stop if the screen was closed while waiting
    if (isClosed) return;

    switch (apiResult) {
      case SuccessBaseResponse<AuthEntity>():
        emit(
          state.copyWith(
            signUpState: state.signUpState.copyWith(
              isLoading: false,
              data: apiResult.data,
            ),
          ),
        );
      case ErrorBaseResponse<AuthEntity>():
        emit(
          state.copyWith(
            signUpState: state.signUpState.copyWith(
              isLoading: false,
              errMsg: apiResult.errMessage,
            ),
          ),
        );
    }
  }
}
