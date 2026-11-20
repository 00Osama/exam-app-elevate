sealed class SignInEvents {}

class SignInEvent extends SignInEvents {
  final String email;
  final String password;
  final bool rememberMe;

  SignInEvent({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}