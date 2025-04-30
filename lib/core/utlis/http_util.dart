import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpUtil {
  final Dio dio;

  // Constructor with required Dio instance
  HttpUtil({required this.dio});

// Post request API
  Future post(
    String path, {
    dynamic myData,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      if (!requestOptions.headers!
          .containsKey(AppConstants.STORAGE_USER_TOKEN_KEY)) {
        // Check if 'token' exists
        //Handle if the token is not passed
        final sv = getIt<StorageServices>();
        String token = sv.getUserToken();
        requestOptions.headers![AppConstants.STORAGE_USER_TOKEN_KEY] = token;
      }
      debugPrint(
          "------Post Method is Triggered: Path - $path, Data - $myData");

      var response = await dio.post(
        path,
        data: myData,
        queryParameters: queryParameters,
        options: requestOptions.copyWith(
          validateStatus: (status) {
            // Let Dio accept all status codes and handle them manually
            return true;
          },
        ),
      );
      debugPrint("Response From Dio ------> : ${response.data}");
      return response.data;
    } on DioException catch (e) {
      String err = _handleDioError(e);
      return {
        'success': false,
        'message': err,
      };
    } catch (e) {
      debugPrint("Error during POST: $e");
      // If there's an unexpected error (not from the server response)
      return {
        'success': false,
        'message': 'An unexpected error occurred',
      };
    }
  }

// Get Request API
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers ??= {}; // Ensure headers are initialized

      // The ONLY place to get the token is from the passed 'options':
      if (!requestOptions.headers!
          .containsKey(AppConstants.STORAGE_USER_TOKEN_KEY)) {
        // Check if 'token' exists
        //Handle if the token is not passed
        final sv = getIt<StorageServices>();
        String token = sv.getUserToken();
        requestOptions.headers![AppConstants.STORAGE_USER_TOKEN_KEY] = token;
      }

      debugPrint(
          "------Post Method is Triggered: Path - $path, Data - $data, header - ${requestOptions.headers}");

      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: requestOptions,
      );

      debugPrint("Response from HTTPUtil ----> : ${response.data}");

      return response.data;
    } on DioException catch (e) {
      String err = _handleDioError(e);
      return {
        'success': false,
        'message': err,
      };
    } catch (e) {
      debugPrint("Error during POST: $e");
      // If there's an unexpected error (not from the server response)
      return {
        'success': false,
        'message': 'An unexpected error occurred',
      };
    }
  }

  Map<String, String>? getAuthorizationHeader() {
    final storageService = getIt<StorageServices>();
    String? token = storageService.getUserToken();

    if (token.isNotEmpty) {
      return {"Authorization": "Bearer $token"};
    }

    return null; // No Authorization header if the token is null or empty
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        // Handle connection timeout
        return 'Connection Timeout';
      case DioExceptionType.receiveTimeout:
        // Handle receive timeout
        return 'Receive Timeout';
      case DioExceptionType.sendTimeout:
        // Handle send timeout
        return 'Send Timeout';
      case DioExceptionType.unknown:
        // Handle other errors
        return 'Other Dio Error';
      case DioExceptionType.badResponse:
        // Handle HTTP errors (e.g., 400, 500)
        final err = error.response?.statusCode;
        return err.toString();
      default:
        return 'Unknown Dio Exception';
    }
  }
}
