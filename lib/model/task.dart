import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task(
      {required String id,
      required String title,
      required String content,
      required bool isCompleted}) = _Task;

  factory Task.of(
      {required String title,
      required String content,
      required bool isCompleted}) {
    return Task(
        id: const Uuid().v4(),
        title: title,
        content: content,
        isCompleted: isCompleted);
  }
}
