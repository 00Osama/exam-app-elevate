import 'package:exam_app_elevate/features/auth/login/data/models/user_model.dart';
import 'package:exam_app_elevate/features/auth/login/domain/entity/sign_in_entity.dart';
import 'package:exam_app_elevate/features/auth/login/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response.g.dart';
@JsonSerializable()
class SignInResponse {
  final String? message;
  final int? code; // only in error case
  final String? token; // only in success case
  final UserModel? user;

  const SignInResponse({this.message, this.code, this.token, this.user});
//mapper 
SignInEntity toDomain() {
  return SignInEntity(
    token: token ?? '',
    user: user?.toDomain() ??
        const UserEntity(
          id: '', username: '', firstName: '', lastName: '',
          email: '', phone: '', isVerified: false,
        ),
  );
}
  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}
