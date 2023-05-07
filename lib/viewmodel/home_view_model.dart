import 'package:flutter_template/infrastructure/repository/task_db_repository.dart';
import 'package:flutter_template/infrastructure/repository/task_repository.dart';
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
      final tasks = await _taskRepository.fetchAll();
      state = AsyncValue.data(HomeState(tasks: tasks));
    } on Exception catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }
}