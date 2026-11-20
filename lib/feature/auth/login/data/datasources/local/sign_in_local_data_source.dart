abstract class AuthLocalDataSource {
  //Token
  Future<void> saveToken(String token);
  Future<String?> getToken();
  
//RememberMe 
  Future<void> saveRememberMe(bool value);
  Future<bool> getRememberMe();

  Future<void> clear();
}