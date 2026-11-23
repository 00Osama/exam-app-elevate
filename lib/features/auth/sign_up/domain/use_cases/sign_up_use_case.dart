import 'package:exam_app_elevate/config/base_response/base_response.dart';
import 'package:exam_app_elevate/features/auth/entity/auth_entity.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/entity/sign_up_param.dart';
import 'package:exam_app_elevate/features/auth/sign_up/domain/reposatorie/sign_up_reposatorie.dart';

class SignUpUseCase {
  final SignUpReposatory _repository;

  SignUpUseCase(this._repository);

  Future<BaseResponse<AuthEntity>> call(SignUpParams params) {
    return _repository.signUp(params: params);
  }
}