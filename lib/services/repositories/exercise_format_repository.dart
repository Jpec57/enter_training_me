import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';

class ExerciseFormatRepository extends ApiService
    implements IRepository<ExerciseFormat> {
  static const getUrl = "/api/exercise_formats/{id}";
  static const getAllUrl = "/api/exercise_formats";

  @override
  Future<bool> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<ExerciseFormat> get(int id) async {
    Response response =
        await getDio().get(getUrl.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    return ExerciseFormat.fromJson(data);
  }

  @override
  Future<List<ExerciseFormat>> getAll() async {
    Response response = await getDio().get(getAllUrl);
    List<dynamic> data = response.data;
    return data.map((e) => ExerciseFormat.fromJson(e)).toList();
  }

  @override
  Future<ExerciseFormat> patch(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<ExerciseFormat> post(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<ExerciseFormat> put(ExerciseFormat data) {
    throw UnimplementedError();
  }
}
