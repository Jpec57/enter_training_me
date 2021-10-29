import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CachedRequest extends HiveObject {
  final DateTime savedDate;
  final String string;

  CachedRequest(this.savedDate, this.string);
}
