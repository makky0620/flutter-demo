import 'package:hive_flutter/hive_flutter.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  DateTime createdAt;

  TaskEntity(
      {required this.id,
      required this.title,
      required this.content,
      required this.isCompleted,
      required this.createdAt});

  @override
  bool operator ==(other) =>
      other is TaskEntity &&
      id == other.id &&
      title == other.title &&
      content == other.content &&
      isCompleted == other.isCompleted &&
      createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, content, isCompleted, createdAt);

  @override
  String toString() {
    return 'TaskEntity('
        'id: $id, '
        'title: $title, '
        'content: $content, '
        'isCompleted: $isCompleted, '
        'createdAt: $createdAt'
        ')';
  }
}
