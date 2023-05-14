import 'package:flutter_template/infrastructure/model/task_entity.dart';
import 'package:flutter_template/infrastructure/repository/task_repository.dart';
import 'package:flutter_template/model/task.dart';
import 'package:flutter_template/viewmodel/task_edit_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_view_model_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late TaskEditViewModel viewModel;
  late TaskRepository taskRepository;

  setUp(() {
    taskRepository = MockTaskRepository();
    viewModel = TaskEditViewModel(taskRepository);
  });

  group('Add', () {
    test('should call save method of repository', () async {
      var task = Task.of(
          title: 'title',
          content: 'content',
          isCompleted: false,
          createdAt: DateTime(1900, 1, 1, 1));

      await viewModel.add(task);

      var entity = TaskEntity(
          id: task.id,
          title: task.title,
          content: task.content,
          isCompleted: task.isCompleted,
          createdAt: task.createdAt);
      verify(taskRepository.save(entity)).called(1);
    });
  });
}
