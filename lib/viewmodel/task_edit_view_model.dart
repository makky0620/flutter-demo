import 'package:flutter_template/infrastructure/model/task_entity.dart';
import 'package:flutter_template/infrastructure/repository/task_db_repository.dart';
import 'package:flutter_template/infrastructure/repository/task_repository.dart';
import 'package:flutter_template/model/task.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final taskEditViewModelProvider = StateNotifierProvider.autoDispose(
    (ref) => TaskEditViewModel(ref.read(taskRepositoryProvider)));

class TaskEditViewModel extends StateNotifier<AsyncValue<void>> {
  final TaskRepository _taskRepository;

  TaskEditViewModel(this._taskRepository) : super(const AsyncValue.loading());

  Future<void> add(Task task) async {
    var entity = TaskEntity(
        id: task.id,
        title: task.title,
        content: task.content,
        isCompleted: task.isCompleted,
        createdAt: task.createdAt);
    await _taskRepository.save(entity);
  }
}
