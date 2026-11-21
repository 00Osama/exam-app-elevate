import 'package:exam_app_elevate/config/base_response/base_response.dart';

// Runs any API call and returns success or error without repeating try-catch
Future<BaseResponse<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final T result = await apiCall();
    return SuccessBaseResponse<T>(data: result);
  } catch (e) {
    return ErrorBaseResponse<T>(errorObj: e);
  }
}