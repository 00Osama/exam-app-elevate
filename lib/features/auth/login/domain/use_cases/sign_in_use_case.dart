import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/auth/login/domain/reposatorie/sign_in_reposatorie.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  final SignInReposatorie _signInReposatories;
  SignInUseCase(this._signInReposatories);
Future<BaseResponse<AuthEntity>> call({
  required String email,
  required String password,
  required bool rememberMe,
}) {
    return _signInReposatories.signIn(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
