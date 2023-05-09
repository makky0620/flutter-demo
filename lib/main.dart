import 'package:flutter/material.dart';
import 'package:flutter_template/infrastructure/model/task_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_template/view/home_page.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskEntityAdapter());
  await Hive.openBox<TaskEntity>('taskBox');

  runApp(const ProviderScope(child: MaterialApp(home: HomePage())));
}
