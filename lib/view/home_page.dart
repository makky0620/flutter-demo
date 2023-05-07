import 'package:flutter/material.dart';
import 'package:flutter_template/viewmodel/home_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
        appBar: AppBar(title: const Text('Todo list')),
        body: state.when(
            data: (data) => const Text('loaded'),
            error: (e, msg) => const Text('Error'),
            loading: () => const Text('loading')));
  }
}
