import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/core/utils/validators.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:exam_app_elevate/features/auth/sign_up/presentation/view_model/sign_up_events.dart';
import 'package:exam_app_elevate/features/auth/sign_up/presentation/view_model/sign_up_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  SignUpViewModel(this._signUpUseCase) : super(const SignUpState());

  void onEvent(SignUpEvents event) {
    switch (event) {
      case SignUpEvent():
        _signUp(
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
          rePassword: event.rePassword,
          phone: event.phone,
        );
      case SignUpFormChangedEvent():
        _onFormChanged(
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
          rePassword: event.rePassword,
          phone: event.phone,
        );
    }
  }

  Future<void> _signUp({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    //start loading
    emit(
      state.copyWith(signUpState: state.signUpState.copyWith(isLoading: true)),
    );

    final BaseResponse<AuthEntity> apiResult = await _signUpUseCase(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );

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

  void _onFormChanged({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) {
    final bool isValid =
        AppValidators.username(username) == null &&
        AppValidators.name(firstName) == null &&
        AppValidators.name(lastName) == null &&
        AppValidators.email(email) == null &&
        AppValidators.password(password) == null &&
        AppValidators.confirmPassword(rePassword, password) == null &&
        AppValidators.phone(phone) == null;
    emit(state.copyWith(isFormValid: isValid));
  }
}
