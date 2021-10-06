import 'dart:io';

import 'package:enter_training_me/storage_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as Get;

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? apiToken = await storage.read(key: StorageConstants.apiKey);
    if (apiToken != null) {
      // print("Sending with token $apiToken ${options.path}");
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
    }
    return handler.next(options);
  }

  //401
  void handleUnauthorized() {
    // if (Get.Get.context != null){
    //   BlocProvider.of<AuthBloc>(Get.Get.context!).add(LoggedOut());
    // }
    // Get.Get.offNamedUntil(LoginPage.routeName, (route) => false);
  }

  //403
  void handleForbidden() {}

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Response? res = err.response;
    if (res != null) {
      if (res.statusCode == 401) {
        handleUnauthorized();
        return handler.reject(err);
      }
      var data = res.data;
      if (data != null &&
          data is Map &&
          data['message'] == "Invalid API Token") {
        handleUnauthorized();
        return handler.reject(err);
      }
    }
    debugPrint(err.response?.statusMessage ?? "Error");
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
