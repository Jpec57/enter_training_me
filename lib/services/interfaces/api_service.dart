import 'package:enter_training_me/services/api_interceptors.dart';
import 'package:enter_training_me/services/interfaces/http_service.dart';
import 'package:dio/dio.dart';

abstract class ApiService extends HttpService {
  static const host = "https://enter-training-me.jpec.be";
  ApiService()
      : super(
            BaseOptions(
              baseUrl: host,
              receiveDataWhenStatusError: true,
              responseType: ResponseType.json,
              // validateStatus: (status) => status != null && status < 500
            ),
            interceptor: ApiInterceptors());
}
