import 'package:exam_app_elevate/Config/Base%20State/base_state.dart';

class ForgetPasswordState {
  final BaseState<void> state;

  const ForgetPasswordState({
    this.state = const BaseState<void>(
      data: null,
      errMsg: null,
      isLoading: false,
    ),
  });

  ForgetPasswordState copyWith({BaseState<void>? state, bool? isSuccess}) {
    return ForgetPasswordState(state: state ?? this.state);
  }
}
