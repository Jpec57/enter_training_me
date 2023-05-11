import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/paginated_list_response.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';
import 'dart:convert';
import 'package:get/get.dart' as get_lib;

class TrainingRepository extends ApiService implements IRepository<Training> {
  static const getAllUrl = "/api/trainings";
  static const getOfficialUri = "/trainings/official";
  static const getByReferenceUri = "/trainings/reference/{id}";
  static const getUrl = "/api/trainings/{id}";
  static const postUser = "/api/trainings";
  static const shareByEmail = "/trainings/{id}/share";
  static const getSavedUrl = "/trainings/saved";
  static const saveTraining = "/trainings/{id}/save";
  static const removeFromSaved = "/trainings/{id}/unsave";

  @override
  Future<Training> get(int id) async {
    Response response =
        await getDio().get(getUrl.replaceFirst("{id}", id.toString()));
    Map<String, dynamic> data = jsonDecode(response.data);
    return Training.fromJson(data);
  }

  Future<PaginatedListResponse<Training>> getUserTrainings(int userId,
      {int page = 0, int limit = 10}) async {
    assert(page >= 0 && limit > 0);
    Map<String, dynamic> queryParameters = {
      "limit": limit,
      "page": page,
    };
    Response response = await getDio()
        .get("/api/users/$userId/trainings", queryParameters: queryParameters);
    dynamic data = response.data;
    return PaginatedListResponse<Training>.fromJson(
        data, (json) => Training.fromJson(json as Map<String, dynamic>));
  }

  Future<bool> shareByEmailAction(int id) async {
    Response response =
        await getDio().get(shareByEmail.replaceFirst("{id}", id.toString()));
    return response.statusCode == 200;
  }

  Future<bool> saveTrainingAction(int id) async {
    try {
      Response response =
          await getDio().get(saveTraining.replaceFirst("{id}", id.toString()));
      return response.statusCode == 200;
    } on DioError catch (e) {
      get_lib.Get.snackbar("Forbidden", "You must be connected to do this :(");
      return false;
    }
  }

  Future<bool> removeFromSavedTrainingAction(int id) async {
    try {
      Response response = await getDio()
          .get(removeFromSaved.replaceFirst("{id}", id.toString()));
      return response.statusCode == 200;
    } on DioError catch (e) {
      get_lib.Get.snackbar("Forbidden", "You must be connected to do this :(");
      return false;
    }
  }

  Future<List<Training>> getSavedTrainings() async {
    try {
      Response response = await getDio().get(getSavedUrl);
      List<dynamic> data = response.data;
      return data.map((e) => Training.fromJson(e)).toList();
    } on DioError catch (e) {
      return [];
    }
  }

  @override
  Future<List<Training>> getAll() async {
    Response response = await getDio().get(getAllUrl);
    List<dynamic> data = response.data;
    return data.map((e) => Training.fromJson(e)).toList();
  }

  Future<List<Training>> getByReference(int id) async {
    Response response = await getDio()
        .get(getByReferenceUri.replaceFirst("{id}", id.toString()));
    List<dynamic> data = response.data;
    return data.map((e) => Training.fromJson(e)).toList();
  }

  Future<List<Training>> getOfficial() async {
    Response response = await getDio().get(getOfficialUri);

    List<dynamic> data = response.data;
    return data.map((e) => Training.fromJson(e)).toList();
  }

  @override
  Future<bool> delete(int id) async {
    Response response =
        await getDio().delete(getUrl.replaceFirst("{id}", id.toString()));
    if (response.statusCode == null) {
      return false;
    }
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }

  Future<Training?> postUserTraining(Map<String, dynamic> data) async {
    data = Training.cleanForCreation(data);
    Response response = await getDio().post(postUser, data: data);
    return Training.fromJson(
        response.data is String ? jsonDecode(response.data) : response.data);
  }

  @override
  Future<Training?> patch(int id, Map<String, dynamic> data) async {
    //should be done in api as well
    if (data.containsKey('isOfficial') && data['isOfficial']) {
      return await postUserTraining(data);
    }
    Response response = await getDio()
        .patch(getUrl.replaceFirst("{id}", id.toString()), data: data);
    if (response.statusCode == null) {
      return null;
    }
    Map<String, dynamic> map =
        response.data is String ? jsonDecode(response.data) : response.data;
    return Training.fromJson(map);
  }

  @override
  Future<Training> post(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Training> put(int id, Training data) {
    throw UnimplementedError();
  }
}
