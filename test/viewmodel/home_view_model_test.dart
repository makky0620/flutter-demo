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
      const task = Task(title: 'title', content: 'content');
      when(taskRepository.fetchAll()).thenAnswer((_) => Future.value([task]));

      await viewModel.load();

      verify(taskRepository.fetchAll()).called(1);
      expect(viewModel.debugState.value!.tasks, [task]);
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
}
