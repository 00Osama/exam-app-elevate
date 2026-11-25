import 'package:equatable/equatable.dart';
import 'package:exam_app_elevate/features/login_and_signup/login/domain/entity/user_entity.dart';

class AuthEntity extends Equatable {
  final String token;
  final UserEntity user;

  const AuthEntity({required this.token, required this.user});

  // Fields used to compare two objects
  @override
  List<Object?> get props => [token, user];
}
