import 'package:dio/dio.dart';
import 'package:zakat/utils/app_constants.dart';
import 'my_error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.badResponse:
              errorDescription = error.response?.data['message'];
              break;
            case DioExceptionType.connectionError:
            case DioExceptionType.cancel:
              // errorDescription = "Request to API server was cancelled";
              errorDescription = AppConstants.networkServerError;
              break;
            case DioExceptionType.connectionTimeout:
              // errorDescription = "Connection timeout with API server";
              errorDescription = AppConstants.networkServerError;
              break;
            case DioExceptionType.unknown:
              errorDescription =
              // "Connection to API server failed due to internet connection";
              AppConstants.networkServerError;
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
              // "Receive timeout in connection with API server";
              AppConstants.networkServerError;
              break;
            case DioExceptionType.values:
              switch (error.response?.statusCode) {
                case 404:
                case 401:
                  errorDescription = error.response?.statusMessage;
                case 400:
                  errorDescription = error.response?.statusMessage;
                  break;
                case 500:
                case 502:
                errorDescription = error.response?.statusMessage;
                break;
                case 503:
                  errorDescription = error.response?.statusMessage;
                  break;
                case 402:
                  MyMethodErrorResponse myMethodErrorResponse =
                  MyMethodErrorResponse.fromJson(error.response?.data);
                  if (myMethodErrorResponse.message.isNotEmpty) {
                    errorDescription = myMethodErrorResponse;
                  } else {
                    errorDescription =
                    "Failed to load data - status code: ${error.response?.statusCode}";
                  }
                  break;
                default:
                  MyErrorResponse errorResponse =
                  MyErrorResponse.fromJson(error.response?.data);
                  if (errorResponse.message.isNotEmpty) {
                    errorDescription = errorResponse;
                  } else {
                    errorDescription =
                    "Failed to load data - status code: ${error.response?.statusCode}";
                  }
              }
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = AppConstants.networkServerError;
              break;
            case DioExceptionType.badCertificate:
            // TODO: Handle this case.
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}