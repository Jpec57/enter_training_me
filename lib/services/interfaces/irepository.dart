abstract class IRepository<T> {
  Future<List<T>> getAll();
  Future<T> get(int id);
  Future<T> post(Map<String, dynamic> data);
  // T post(T data);
  Future<T> put(T data);
  Future<T> patch(Map<String, dynamic> data);
  Future<bool> delete(int id);
}