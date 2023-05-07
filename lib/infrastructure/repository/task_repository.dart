import 'package:flutter_template/model/task.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchAll();
}
