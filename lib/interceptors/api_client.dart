import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIClient {
  late Dio _dio;

  APIClient() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://10.0.2.2:5000/auth/',
    );

    _dio = Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, handler) async {
        if (error.response?.statusCode == 401) {
          // Handle 401 error and obtain a refresh token
          // For example, you can make another API request to get a new access token
          try {
            String? refreshToken = await loadData("refreshToken");
            Map<String, dynamic> postData = {'refreshToken': refreshToken};
            Response response =
                await _dio.post('/refresh-token', data: postData);
            // Extract and store the refresh token
            String newAccessToken = response.data['accessToken'];
            saveData("accessToken", newAccessToken);
            print("accessToken saved");
            // Do something with the refresh token (e.g., store it for future use)
          } catch (e) {
            // Handle the error while obtaining the refresh token
            print('Error obtaining access token: $e');
          }
        }
        return handler.next(error);
      },
    ));
  }

  Dio get dioInstance => _dio;

  Future<String?> loadData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
