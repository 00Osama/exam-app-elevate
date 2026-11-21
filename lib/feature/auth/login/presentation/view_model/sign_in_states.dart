import 'package:equatable/equatable.dart';
import 'package:exam_app_elevate/config/base_state/base_state.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';

class SignInState extends Equatable {
  final BaseState<SignInEntity> signInState;
  final bool isFormValid;

  const SignInState({
    this.signInState = const BaseState(),
    this.isFormValid = false,
  });

  SignInState copyWith({
    BaseState<SignInEntity>? signInState,
    bool? isFormValid,
  }) {
    return SignInState(
      signInState: signInState ?? this.signInState,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [signInState, isFormValid];
}