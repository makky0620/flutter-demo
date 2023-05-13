import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_template/model/task.dart';
import 'package:flutter_template/viewmodel/task_edit_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TaskEditPage extends HookConsumerWidget {
  const TaskEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(taskEditViewModelProvider.notifier);

    var title = useState<String>('');
    var content = useState<String>('');
    var titleController = useTextEditingController();
    var contentController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('New task')),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: 'タイトルを入力してください', labelText: 'Title'),
                onChanged: (value) {
                  title.value = value;
                },
              ),
              const SizedBox(height: 40),
              Expanded(
                  child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                    hintText: 'タスク詳細を入力してください', labelText: 'Detail'),
                onChanged: (value) {
                  content.value = value;
                },
              ))
            ],
          )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            viewModel
                .add(Task.of(
                    title: title.value,
                    content: content.value,
                    isCompleted: false,
                    createdAt: DateTime.now()))
                .then((value) => Navigator.of(context).pop());
          }),
    );
  }
}
