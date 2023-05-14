import 'package:flutter/material.dart';
import 'package:flutter_template/infrastructure/model/task_entity.dart';
import 'package:flutter_template/infrastructure/repository/task_db_repository.dart';
import 'package:flutter_template/infrastructure/repository/task_repository.dart';
import 'package:flutter_template/view/home_page.dart';
import 'package:flutter_template/view/task_edit_page.dart';
import 'package:flutter_template/view/widget/task_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late Provider<TaskRepository> mockTaskRepositoryProvider;
  late TaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    mockTaskRepositoryProvider =
        Provider<TaskRepository>((_) => mockTaskRepository);
  });

  render(tester) async {
    await tester.pumpWidget(ProviderScope(overrides: [
      taskRepositoryProvider.overrideWithProvider(mockTaskRepositoryProvider)
    ], child: const MaterialApp(home: HomePage())));
  }

  testWidgets('should move to task edit page when floading button is pushed',
      (tester) async {
    when(mockTaskRepository.fetchAll()).thenAnswer((_) => Future.value([]));

    await render(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(TaskEditPage), findsOneWidget);
  });

  testWidgets('shold show task items', (tester) async {
    var dummyTaskEntity = TaskEntity(
        id: 'id',
        title: 'title',
        content: 'content',
        isCompleted: false,
        createdAt: DateTime(1900, 1, 1, 1));
    when(mockTaskRepository.fetchAll()).thenAnswer((_) =>
        Future.value([dummyTaskEntity, dummyTaskEntity, dummyTaskEntity]));

    await render(tester);
    await tester.pumpAndSettle();

    expect(find.byType(TaskItem), findsNWidgets(3));
  });
}
