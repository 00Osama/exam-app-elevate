import 'package:exam_app_elevate/features/login_and_signup/sign_up/domain/entity/sign_up_param.dart';

sealed class SignUpEvents {}

class SignUpEvent extends SignUpEvents {
  final SignUpParams params;
  SignUpEvent(this.params);
}

class SignUpFormChangedEvent extends SignUpEvents {
  final SignUpParams params;
  SignUpFormChangedEvent(this.params);
}
