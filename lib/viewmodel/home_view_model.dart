import 'package:flutter_template/infrastructure/model/task_entity.dart';
import 'package:flutter_template/infrastructure/repository/task_db_repository.dart';
import 'package:flutter_template/infrastructure/repository/task_repository.dart';
import 'package:flutter_template/model/task.dart';
import 'package:flutter_template/viewmodel/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, AsyncValue<HomeState>>(
        (ref) => HomeViewModel(ref.read(taskRepositoryProvider)));

class HomeViewModel extends StateNotifier<AsyncValue<HomeState>> {
  final TaskRepository _taskRepository;

  HomeViewModel(this._taskRepository) : super(const AsyncValue.loading());

  Future<void> load() async {
    try {
      List<TaskEntity> tasks = await _taskRepository.fetchAll();
      state = AsyncValue.data(HomeState(tasks: _toTasks(tasks)));
    } on Exception catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _taskRepository.delete(taskId);
    } on Exception catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<void> switchStatus(Task task, bool value) async {
    try {
      var newTask = TaskEntity(
          id: task.id,
          title: task.title,
          content: task.content,
          isCompleted: value);
      await _taskRepository.update(newTask);
    } on Exception catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  List<Task> _toTasks(List<TaskEntity> tasks) {
    return tasks
        .map((e) => Task(
            id: e.id,
            title: e.title,
            content: e.content,
            isCompleted: e.isCompleted))
        .toList();
  }
}
