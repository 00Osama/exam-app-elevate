import 'package:dio/dio.dart';
import 'package:exam_app_elevate/Config/Constants/app_end_points.dart';
import 'package:injectable/injectable.dart';


@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(
      BaseOptions(
        baseUrl: AppEndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      )
  );
}