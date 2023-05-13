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

  group('Fetch all', () {
    test('should set tasks to state', () async {
      var task = TaskEntity(id: 'task', 
                            title: 'title',
			    content: 'content',
			    isCompleted: false,
			    createdAt: DateTime(2023, 5, 14, 10));
      when(taskRepository.fetchAll()).thenAnswer((_) => Future.value([task]));

      await viewModel.load();

      verify(taskRepository.fetchAll()).called(1);
      expect(viewModel.debugState.value!.tasks,
          [Task(id: 'task', 
	              title: 'title', 
		      content: 'content',
		      isCompleted: false,
		      createdAt: DateTime(2023, 5, 14, 10))]);
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
  });
}
