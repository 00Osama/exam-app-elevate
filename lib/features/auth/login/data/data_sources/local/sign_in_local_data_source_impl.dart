import 'package:exam_app_elevate/core/constants/storage_keys.dart';
import 'package:exam_app_elevate/features/auth/login/data/data_sources/local/sign_in_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:SignInLocalDataSource)
class SignInLocalDataSourceImpl implements SignInLocalDataSource{
  final FlutterSecureStorage _storage;
  SignInLocalDataSourceImpl(this._storage);
  //Token 
  @override
  Future<void> saveToken(String token) async {
  return _storage.write(key: StorageKeys.token, value: token);
  }

  @override
  Future<String?> getToken() async{
   return _storage.read(key: StorageKeys.token);
  }


//RememberMe 

  @override
  Future<void> saveRememberMe(bool value) {
      return _storage.write(key: StorageKeys.rememberMe, value:value.toString());

  }
 @override
Future<bool> getRememberMe() async {
  final String? value = await _storage.read(key: StorageKeys.rememberMe);
  return value == 'true';
}

//Clear 
    @override
  Future<void> clear() async{
  await _storage.delete(key: StorageKeys.token);
  await _storage.delete(key: StorageKeys.rememberMe); 
   }
}