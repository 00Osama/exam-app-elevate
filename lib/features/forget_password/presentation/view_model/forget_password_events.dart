class ForgetPasswordEvent {}

class SendEmailEvent extends ForgetPasswordEvent {}

class ResetPasswordEvent extends ForgetPasswordEvent {}
