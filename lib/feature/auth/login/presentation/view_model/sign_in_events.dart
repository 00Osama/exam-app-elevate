sealed class SignInEvents {}

// Sent when the user presses the login button
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

// Sent on every change in the email or password field
class FormChangedEvent extends SignInEvents {
  final String email;
  final String password;

  FormChangedEvent({required this.email, required this.password});
}
