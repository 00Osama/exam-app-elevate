import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/auth/login/domain/repository/sign_in_reposatorie.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  final SignInRepository _signInRepositorys;
  SignInUseCase(this._signInRepositorys);
Future<BaseResponse<AuthEntity>> call({
  required String email,
  required String password,
  required bool rememberMe,
}) {
    return _signInRepositorys.signIn(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
