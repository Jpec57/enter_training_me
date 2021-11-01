import 'package:hive/hive.dart';

part 'cached_request.g.dart';

//between 0 and 223
@HiveType(typeId: 0)
class CachedRequest extends HiveObject {
  @HiveField(0)
  final DateTime savedDate;
  @HiveField(1)
  final String string;

  CachedRequest(this.savedDate, this.string);
}
