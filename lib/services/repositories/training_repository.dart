import 'package:ctraining/services/interfaces/api_service.dart';
import 'package:ctraining/services/interfaces/irepository.dart';

class TrainingRepository extends ApiService implements IRepository {
  @override
  get(int id) {
    throw UnimplementedError();
  }

  @override
  List getAll() {
    throw UnimplementedError();
  }

  @override
  patch(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  post(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  put(data) {
    throw UnimplementedError();
  }

  @override
  bool delete(int id) {
    throw UnimplementedError();
  }
}