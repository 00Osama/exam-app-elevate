import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class SignInEntity extends Equatable {
  final String token;
  final UserEntity user;

  const SignInEntity({required this.token, required this.user});

  // Fields used to compare two objects
  @override
  List<Object?> get props => [token, user];
}