class UserEntity {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.isVerified,
  });

  @override
  String toString() =>
      'UserEntity(id: $id, username: $username, email: $email)';
}