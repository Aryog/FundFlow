import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_utilities.dart';

class APIClient {
  late Dio _dio;
  late RequestOptions _retryOptions;

  APIClient() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://10.0.2.2:5000/auth/',
    );

    _dio = Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve the access token
        String? accessToken = await Utils.loadData("accessToken");
        // Add the access token to the request headers
        options.headers['Authorization'] = accessToken;
        _retryOptions = options;

        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        if (error.response?.statusCode == 401) {
          // Handle 401 error and obtain a access token
          // For example, you can make another API request to get a new access token
          try {
            String? refreshToken = await Utils.loadData("refreshToken");
            Map<String, dynamic> postData = {'refreshToken': refreshToken};
            Response response =
                await _dio.post('/refresh-token', data: postData);
            // Extract and store the access token
            String newAccessToken = response.data['accessToken'];
            if (newAccessToken != null) {
              // If the token refresh is successful, update the stored token and retry the request
              print("newAccessToken");
              await Utils.saveData("accessToken", newAccessToken);
              _retryOptions.headers['Authorization'] = newAccessToken;
              return handler.resolve(await _dio.fetch(error.requestOptions));
            } else {
              return;
            }
            // Do something with the access token (e.g., store it for future use)
          } catch (e) {
            // Handle the error while obtaining the refresh token
            print('Error obtaining access token: $e');
          }
        }
        return handler.reject(error);
      },
    ));
  }

  Dio get dioInstance => _dio;
}
