import 'package:ctraining/services/api_interceptors.dart';
import 'package:ctraining/services/interfaces/http_service.dart';
import 'package:dio/dio.dart';


abstract class ApiService extends HttpService {

  ApiService() : super(BaseOptions(
    baseUrl: "https://enter-training-me.jpec.be",
    // baseUrl: "https://learning-language.jpec.be"
    receiveDataWhenStatusError: true,
    // validateStatus: (status) => status != null && status < 500
  ), interceptor: ApiInterceptors());
}