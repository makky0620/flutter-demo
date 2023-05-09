import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  TaskEntity({required this.id, required this.title, required this.content});

  factory TaskEntity.of(String? title, String? content) => TaskEntity(
      id: const Uuid().v4(), title: title ?? '', content: content ?? '');
}
