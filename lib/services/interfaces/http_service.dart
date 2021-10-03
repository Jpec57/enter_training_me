import 'package:dio/dio.dart';

abstract class HttpService {
  final BaseOptions options;
  final Interceptor? interceptor;
  Dio? dio;

  HttpService(this.options, {this.interceptor});

  Dio getDio() {
    if (dio == null) {
      dio = Dio(options);
      if (interceptor != null) {
        dio!.interceptors.add(interceptor!);
      }
    }
    return dio!;
  }
}
