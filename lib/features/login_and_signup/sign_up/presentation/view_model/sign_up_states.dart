import 'package:equatable/equatable.dart';
import 'package:exam_app_elevate/config/base_state/base_state.dart';
import 'package:exam_app_elevate/features/login_and_signup/entity/auth_entity.dart';

class SignUpState extends Equatable {
  final BaseState<AuthEntity> signUpState;
  final bool isFormValid;

  const SignUpState({
    this.signUpState = const BaseState(),
    this.isFormValid = false,
  });

  SignUpState copyWith({
    BaseState<AuthEntity>? signUpState,
    bool? isFormValid,
  }) {
    return SignUpState(
      signUpState: signUpState ?? this.signUpState,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [signUpState, isFormValid];
}
