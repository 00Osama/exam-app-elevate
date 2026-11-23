// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/forget_password/api/api_client.dart' as _i465;
import '../../features/forget_password/data/data_source/implement/remote/remote_data_source_impl.dart'
    as _i280;
import '../../features/forget_password/data/data_source/interface/remote/remote_data_source.dart'
    as _i612;
import '../../features/forget_password/data/repos/forget_password_repo_impl.dart'
    as _i216;
import '../../features/forget_password/domain/repos/forget_password_repo.dart'
    as _i639;
import '../../features/forget_password/domain/use_cases/reset_password_use_case.dart'
    as _i56;
import '../../features/forget_password/domain/use_cases/send_email_use_case.dart'
    as _i989;
import '../../features/forget_password/presentation/view_model/forget_password_view_model.dart'
    as _i416;
import '../DIo/dio_module.dart' as _i100;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i465.AuthApiClient>(
      () => _i465.AuthApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i612.RemoteDataSource>(
      () => _i280.RemoteDataSourceImpl(gh<_i465.AuthApiClient>()),
    );
    gh.lazySingleton<_i639.ForgetPasswordRepository>(
      () => _i216.ForgetPasswordRepoImpl(gh<_i612.RemoteDataSource>()),
    );
    gh.lazySingleton<_i56.ResetPasswordUseCase>(
      () => _i56.ResetPasswordUseCase(gh<_i639.ForgetPasswordRepository>()),
    );
    gh.lazySingleton<_i989.SendEmailUseCase>(
      () => _i989.SendEmailUseCase(gh<_i639.ForgetPasswordRepository>()),
    );
    gh.factory<_i416.ForgetPasswordViewModel>(
      () => _i416.ForgetPasswordViewModel(
        gh<_i989.SendEmailUseCase>(),
        gh<_i56.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i100.DioModule {}
