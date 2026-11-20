import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/core/utils/validators.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/usecases/sign_in_use_case.dart';
import 'package:exam_app_elevate/feature/auth/login/presentation/viewmodel/sign_in_events.dart';
import 'package:exam_app_elevate/feature/auth/login/presentation/viewmodel/sign_in_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInViewModel extends Cubit<SignInStates> {
  final SignInUseCase _signInUseCase;

  SignInViewModel(this._signInUseCase) : super(const InitialSignInState());

  // The only entry point for the view
  void onEvent(SignInEvents event) {
    switch (event) {
      case SignInEvent():
        _signIn(
          email: event.email,
          password: event.password,
          rememberMe: event.rememberMe,
        );
      case FormChangedEvent():
        _onFormChanged(email: event.email, password: event.password);
    }
  }

  // Checks the fields and emits only if the validity changed
  void _onFormChanged({required String email, required String password}) {
    final bool isValid =
        Validators.email(email) == null &&
        Validators.password(password) == null;

    if (isValid == state.isFormValid) return;

    emit(FormChangedSignInState(isFormValid: isValid));
  }

  Future<void> _signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(LoadingSignInState(isFormValid: state.isFormValid));

    final BaseResponse<SignInEntity> apiResult = await _signInUseCase(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    // Stop if the screen was closed while waiting
    if (isClosed) return;

    switch (apiResult) {
      case SuccessBaseResponse<SignInEntity>():
        emit(
          SuccessSignInState(
            signInEntity: apiResult.data,
            isFormValid: state.isFormValid,
          ),
        );
      case ErrorBaseResponse<SignInEntity>():
        emit(
          ErrorSignInState(
            errMsg: apiResult.errMessage,
            isFormValid: state.isFormValid,
          ),
        );
    }
  }
}
