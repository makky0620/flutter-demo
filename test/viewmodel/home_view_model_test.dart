import 'package:flutter_template/infrastructure/model/task_entity.dart';
import 'package:flutter_template/infrastructure/repository/task_repository.dart';
import 'package:flutter_template/model/task.dart';
import 'package:flutter_template/viewmodel/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_view_model_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late HomeViewModel viewModel;
  late TaskRepository taskRepository;

  setUp(() {
    taskRepository = MockTaskRepository();
    viewModel = HomeViewModel(taskRepository);
  });

  group('Load', () {
    test('should set tasks to state', () async {
      var task = TaskEntity(
          id: 'task',
          title: 'title',
          content: 'content',
          isCompleted: false,
          createdAt: DateTime(2023, 5, 14, 10));
      when(taskRepository.fetchAll()).thenAnswer((_) => Future.value([task]));

      await viewModel.load();

      verify(taskRepository.fetchAll()).called(1);
      expect(viewModel.debugState.value!.tasks, [
        Task(
            id: 'task',
            title: 'title',
            content: 'content',
            isCompleted: false,
            createdAt: DateTime(2023, 5, 14, 10))
      ]);
    });

    test('should set error to state when repository throws exception',
        () async {
      when(taskRepository.fetchAll())
          .thenAnswer((_) => Future.error(Exception('error')));

      await viewModel.load();

      verify(taskRepository.fetchAll()).called(1);
      expect(viewModel.debugState.error, isException);
    });
  });

  group('Delete task', () {
    test('should call delete of repository', () async {
      var taskId = 'task';

      await viewModel.deleteTask(taskId);

      verify(taskRepository.delete(taskId)).called(1);
    });

    test('should set error to state when repository throws exception',
        () async {
      var taskId = 'task';
      when(taskRepository.delete(taskId))
          .thenAnswer((_) => Future.error(Exception('error')));

      await viewModel.deleteTask(taskId);

      verify(taskRepository.delete(taskId)).called(1);
      expect(viewModel.debugState.error, isException);
    });
  });

  group('Switch status', () {
    test('should call with the task changed completed frag', () async {
      var task = Task.of(
          title: 'dummy',
          content: 'dummy',
          isCompleted: false,
          createdAt: DateTime(2023, 5, 14, 10));

      await viewModel.switchStatus(task, true);

      var changedTask = TaskEntity(
          id: task.id,
          title: task.title,
          content: task.content,
          isCompleted: true,
          createdAt: task.createdAt);
      verify(taskRepository.update(changedTask)).called(1);
    });

    test('should set error to state when repository throws exception',
        () async {
      var task = Task.of(
          title: 'dummy',
          content: 'dummy',
          isCompleted: false,
          createdAt: DateTime(1900, 1, 1, 1));
      var entity = TaskEntity(
          id: task.id,
          title: 'dummy',
          content: 'dummy',
          isCompleted: true,
          createdAt: DateTime(1900, 1, 1, 1));
      when(taskRepository.update(entity))
          .thenAnswer((_) => Future.error(Exception('error')));

      await viewModel.switchStatus(task, true);

      verify(taskRepository.update(entity)).called(1);
      expect(viewModel.debugState.error, isException);
    });
  });
}
