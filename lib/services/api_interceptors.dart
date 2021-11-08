import 'dart:io';
import 'package:enter_training_me/storage_constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_lib;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? apiToken = await storage.read(key: StorageConstants.apiKey);
    if (apiToken != null) {
      debugPrint("Sending with token $apiToken ${options.path}");
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
    }
    return handler.next(options);
  }

  //401
  void handleUnauthorized() async {
    get_lib.Get.snackbar(
        "Log in", "You have been disconnected. Please log again");
    FlutterSecureStorage storage = const FlutterSecureStorage();
    storage.delete(key: StorageConstants.apiKey);
    //TODO SHOW LOGIN DIALOG AND WAY TO RESUME REQUEST
  }

  //403
  void handleForbidden() {}

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Response? res = err.response;
    debugPrint("OnError");
    debugPrint(err.response.toString());
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
