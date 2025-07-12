import 'package:hive/hive.dart';

part 'daily_counter_data.g.dart';

@HiveType(typeId: 0) // Unique typeId for this object
class DailyCounterData extends HiveObject {
  @HiveField(0)
  int count;

  @HiveField(1)
  DateTime lastUpdatedDate;

  DailyCounterData({required this.count, required this.lastUpdatedDate});
}