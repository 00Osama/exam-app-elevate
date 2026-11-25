import 'package:exam_app_elevate/features/login_and_signup/login/domain/repository/sign_in_reposatorie.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsLoggedInUseCase {
  final SignInRepository _signInReposatory;

  IsLoggedInUseCase(this._signInReposatory);

  Future<bool> call() => _signInReposatory.isLoggedIn();
}
