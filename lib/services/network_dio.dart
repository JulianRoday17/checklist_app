import 'package:dio/dio.dart';

class NetworkDio {
  static Dio createDio() {
    final String baseUrl = 'http://94.74.86.174:8080/api';
    final options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
      // followRedirects: false,
      // validateStatus: (status) {
      //   return status <= 500;
      // },
      // receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );
    Dio dio = Dio(options);
    return dio;
  }
}
