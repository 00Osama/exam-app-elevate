import 'user_entity.dart';

class SignInEntity {
  final String token;
  final UserEntity user;

  const SignInEntity({required this.token, required this.user});

  @override
  String toString() => 'SignInEntity(user: $user)';
}