sealed class SignUpEvents {}

class SignUpEvent extends SignUpEvents {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  SignUpEvent({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });
}

class SignUpFormChangedEvent extends SignUpEvents {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  SignUpFormChangedEvent({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });
}