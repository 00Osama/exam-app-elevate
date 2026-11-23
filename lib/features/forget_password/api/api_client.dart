import 'package:dio/dio.dart';
import 'package:exam_app_elevate/Config/Constants/app_end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'api_client.g.dart';

@RestApi()
@lazySingleton
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(AppEndPoints.forgotPassword)
  Future<void> sendEmailForResetPassword(String email);

  @POST(AppEndPoints.resetPassword)
  Future<void> resetPassword(String password);
}
