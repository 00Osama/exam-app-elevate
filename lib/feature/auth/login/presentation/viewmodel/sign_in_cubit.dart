import 'package:exam_app_elevate/Config/BaseResponse/base_response.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/usecases/sign_in_use_case.dart';
import 'package:exam_app_elevate/feature/auth/login/presentation/viewmodel/sign_in_events.dart';
import 'package:exam_app_elevate/feature/auth/login/presentation/viewmodel/sign_in_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInViewModel extends Cubit<SignInStates> {
  final SignInUseCase _signInUseCase;

  SignInViewModel(this._signInUseCase) : super(InitialSignInState());

  void onEvent(SignInEvents event) {
  switch (event) {
    case SignInEvent():
      _signIn(
        email: event.email,
        password: event.password,
        rememberMe: event.rememberMe,
      );
  }
}
    
  Future<void> _signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(LoadingSignInState());
    BaseResponse<SignInEntity> signIn = await _signInUseCase(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    switch(signIn){
      case SuccessBaseResponse<SignInEntity>():
       emit(SuccessSignInState(signInEntity: signIn.data));
      case ErrorBaseResponse<SignInEntity>():
       emit(ErrorSignInState(errMsg: signIn.errMessage));
    }
  }
}
