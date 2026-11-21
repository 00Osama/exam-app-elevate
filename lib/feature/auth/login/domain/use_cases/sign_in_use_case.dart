import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/entity/sign_in_entity.dart';
import 'package:exam_app_elevate/feature/auth/login/domain/reposatorie/sign_in_reposatories.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  final SignInReposatorie _signInReposatories;
  SignInUseCase(this._signInReposatories);
Future<BaseResponse<SignInEntity>> call({
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
