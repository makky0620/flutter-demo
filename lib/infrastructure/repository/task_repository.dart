import 'package:flutter_template/infrastructure/model/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> fetchAll();

  Future<void> save(TaskEntity task);

  Future<void> delete(String id);

  Future<void> update(TaskEntity task);
}
