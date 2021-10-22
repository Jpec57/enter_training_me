import 'package:dio/dio.dart';
import 'package:enter_training_me/models/execution_style.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';

class ExecutionStyleRepository extends ApiService implements IRepository<ExecutionStyle> {
  static const getUrl = "/api/execution_styles/{id}";
  static const getAllUrl = "/api/execution_styles";

  @override
  Future<bool> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<ExecutionStyle> get(int id) async {
    Response response =
        await getDio().get(getUrl.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    return ExecutionStyle.fromJson(data);
  }

  @override
  Future<List<ExecutionStyle>> getAll() async {
    Response response = await getDio().get(getAllUrl);
    List<dynamic> data = response.data;
    return data.map((e) => ExecutionStyle.fromJson(e)).toList();
  }

  @override
  Future<ExecutionStyle> patch(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<ExecutionStyle> post(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<ExecutionStyle> put(ExecutionStyle data) {
    throw UnimplementedError();
  }


}
