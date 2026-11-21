import 'dart:developer';
import 'package:dio/dio.dart';
import '../constants/api_constant.dart';

sealed class BaseResponse<T> {
  const BaseResponse();
}

class SuccessBaseResponse<T> extends BaseResponse<T> {
  final T data;

  const SuccessBaseResponse({required this.data});
}

class ErrorBaseResponse<T> extends BaseResponse<T> {
  final String errMessage;
  final int? statusCode;

  const ErrorBaseResponse.fromErrorMsg(this.errMessage) : statusCode = null;

  ErrorBaseResponse({Object? errorObj})
      : errMessage = errorObj == null
      ? ApiConstant.genericErrorMsg
      : _getErrorMsg(errorObj),
        statusCode = errorObj is DioException
            ? errorObj.response?.statusCode
            : null;

  static String _getErrorMsg(Object error) {
    log(error.toString(), name: "ErrorBaseResponse");

    if (error is! DioException) return ApiConstant.genericErrorMsg;

    switch (error.type) {
      case DioExceptionType.connectionError:
        return "No internet connection";
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Connection timed out, please try again";
      case DioExceptionType.cancel:
        return "Request cancelled";
      case DioExceptionType.badResponse:
      //the message the server sent, if there is one
        final serverMsg = _extractServerMsg(error.response?.data);
        if (serverMsg != null) return serverMsg;
        //otherwise a message based on the status code
        return _getStatusCodeErrorMsg(error.response?.statusCode);
      default:
        return ApiConstant.genericErrorMsg;
    }
  }

  static String? _extractServerMsg(dynamic data) {
    if (data is Map<String, dynamic>) {
      final msg = data['message'];
      if (msg is String && msg.isNotEmpty) return msg;
    }
    return null;
  }

  static String _getStatusCodeErrorMsg(int? code) {
    switch (code) {
      case 400:
        return "Invalid request";
      case 401:
        return "Session expired, please login again";
      case 403:
        return "You don't have permission to do this";
      case 404:
        return "Not found";
      case 409:
        return "Already exists";
      default:
        if (code != null && code >= 500) return "Server error, try again later";
        return ApiConstant.genericErrorMsg;
    }
  }
}