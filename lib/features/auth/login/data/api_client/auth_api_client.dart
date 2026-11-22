import 'package:dio/dio.dart';
import 'package:exam_app_elevate/core/constants/app_end_points.dart';
import 'package:exam_app_elevate/features/auth/login/data/models/sign_in_request.dart';
import 'package:exam_app_elevate/features/auth/models/auth_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class AuthApiClient {
  // injectable uses this factory and resolves Dio from GetIt
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(AppEndPoints.signIn)
  Future<AuthResponseModel> signIn(@Body() SignInRequest request);
}