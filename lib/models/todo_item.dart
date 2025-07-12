import 'package:hive/hive.dart';

part 'todo_item.g.dart'; // This will be generated

@HiveType(typeId: 1) // Unique typeId for this object (different from DailyCounterData)
class TodoItem extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  DateTime createdAt;

  TodoItem({
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });
}