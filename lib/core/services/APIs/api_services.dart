import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio;
  ApiServices({required Dio dio}) : _dio = dio;
  Future<Map<String, dynamic>> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    var response = await _dio.get(
      endPoint,
      options: Options(headers: headers),
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
