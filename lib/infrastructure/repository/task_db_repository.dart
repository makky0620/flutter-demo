import 'package:flutter_template/infrastructure/model/task_entity.dart';
import 'package:flutter_template/infrastructure/repository/task_repository.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final taskRepositoryProvider =
    Provider<TaskRepository>((ref) => TaskDBRepository(Hive.box('taskBox')));

class TaskDBRepository implements TaskRepository {
  Box<TaskEntity> box;

  TaskDBRepository(this.box);

  @override
  Future<List<TaskEntity>> fetchAll() async {
    return box.values.toList();
  }

  @override
  Future<void> save(TaskEntity task) async {
    await box.put(task.id, task);
  }

  @override
  Future<void> delete(String id) async {
    await box.delete(id);
  }
}
