import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:dio/dio.dart';

class HttpUtil {
  final Dio dio;

  // Constructor with required Dio instance
  HttpUtil({required this.dio});

// post request API
  Future post(
    String path, {
    dynamic myData,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      Map<String, dynamic>? authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }
      print("------Post Method is Triggered: Path - $path, Data - $myData");

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
      print("Response From Dio ------> : ${response.data}");
      return response.data;
    } catch (e) {
      print("Error during POST: $e");

      // If there's an unexpected error (not from the server response)
      return {
        'success': false,
        'message': 'An unexpected error occurred',
      };
    }
    // try {

    // } on DioException catch (e) {
    //   print("Error during POST: ${e.message}");
    //   print("Status code: ${e.response?.statusCode}");
    //   print("Response data: ${e.response?.data}");
    //   throw e; // Rethrow to handle at a higher level
    // }
  }

  Map<String, String>? getAuthorizationHeader() {
    final storageService = getIt<StorageServices>();
    String? token = storageService.getUserToken();

    if (token.isNotEmpty) {
      return {"Authorization": "Bearer $token"};
    }

    return null; // No Authorization header if the token is null or empty
  }
}

//  String errorMessage = "Unknown error occurred";
//       if (e.response != null) {
//         // If there is a response, display the server response message
//         errorMessage = e.response?.data['msg'] ??
//             e.response?.data['message'] ??
//             'Server error';
//         print("Error Message from Server: $errorMessage");