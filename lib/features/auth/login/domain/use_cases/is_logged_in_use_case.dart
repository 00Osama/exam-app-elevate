import 'package:exam_app_elevate/features/auth/login/domain/reposatorie/sign_in_reposatorie.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsLoggedInUseCase {
  final SignInReposatory _signInReposatory;

  IsLoggedInUseCase(this._signInReposatory);

  Future<bool> call() => _signInReposatory.isLoggedIn();
}