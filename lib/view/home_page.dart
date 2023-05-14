import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_template/view/task_edit_page.dart';
import 'package:flutter_template/view/widget/task_item.dart';
import 'package:flutter_template/viewmodel/home_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final viewModel = ref.watch(homeViewModelProvider.notifier);

    useEffect(() {
      viewModel.load();
      return;
    }, const []);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo list')),
      body: state.when(
          data: (data) {
            return ListView.builder(
                itemCount: data.tasks.length,
                itemBuilder: (context, index) {
                  var task = data.tasks[index];
                  return TaskItem(
                      task: task,
                      onSlide: (direction) {
                        viewModel
                            .deleteTask(task.id)
                            .then((_) => viewModel.load());
                      },
                      onCheck: (value) {
                        viewModel
                            .switchStatus(task, value)
                            .then((_) => viewModel.load());
                      });
                });
          },
          error: (e, msg) => const Text('Error'),
          loading: () => const Scaffold(
              body: SafeArea(
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.red))))),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TaskEditPage()))
              .then((value) => viewModel.load());
        },
      ),
    );
  }
}
