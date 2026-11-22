import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/reposatorie/sign_up_reposatorie.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase {
  final SignUpReposatorie _signUpReposatorie;
  SignUpUseCase(this._signUpReposatorie);

  Future<BaseResponse<AuthEntity>> call({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) {
    return _signUpReposatorie.signUp(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );
  }
}
