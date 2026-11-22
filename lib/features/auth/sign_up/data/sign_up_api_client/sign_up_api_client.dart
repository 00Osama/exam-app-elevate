import 'package:dio/dio.dart';
import 'package:exam_app_elevate/config/constants/app_end_points.dart';
import 'package:exam_app_elevate/features/auth/models/auth_response_model.dart';
import 'package:exam_app_elevate/features/auth/sign_up/data/models/sign_up_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'sign_up_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class SignUpApiClient {
  // injectable uses this factory and resolves Dio from GetIt
  @factoryMethod
  factory SignUpApiClient(Dio dio) = _SignUpApiClient;

  @POST(AppEndPoints.signUp)
   Future<AuthResponseModel> signUp(@Body() SignUpRequest request);
  }