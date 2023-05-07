import 'package:flutter_template/model/task.dart';
import 'package:flutter_template/infrastructure/repository/task_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final taskRepositoryProvider =
    Provider<TaskRepository>((ref) => TaskDBRepository());

class TaskDBRepository implements TaskRepository {
  @override
  Future<List<Task>> fetchAll() async {
    return [];
  }
}
