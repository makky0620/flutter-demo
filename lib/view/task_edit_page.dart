import 'package:flutter/material.dart';
import 'package:flutter_template/model/task.dart';
import 'package:flutter_template/viewmodel/task_edit_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TaskEditPage extends HookConsumerWidget {
  const TaskEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(taskEditViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('New task')),
      body: const Text(''),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            viewModel
                .add(const Task(title: 'title', content: 'content'))
                .then((value) => Navigator.of(context).pop());
          }),
    );
  }
}
