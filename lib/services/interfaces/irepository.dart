abstract class IRepository<T> {
  List<T> getAll();
  T get(int id);
  T post(Map<String, dynamic> data);
  // T post(T data);
  T put(T data);
  T patch(Map<String, dynamic> data);
  bool delete(int id);
}