import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({@Default('') String title, @Default('') String content}) =
      _Task;
}
