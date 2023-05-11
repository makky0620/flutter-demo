import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_template/model/task.dart';

class TaskItem extends HookWidget {
  final Task task;
  final int index;
  final Function(DismissDirection) onSlide;
  final ValueChanged onCheck;

  const TaskItem(
      {Key? key,
      required this.task,
      required this.index,
      required this.onSlide,
      required this.onCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Dismissible(
        key: Key(task.title),
        onDismissed: onSlide,
        direction: DismissDirection.startToEnd,
        background: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            color: Colors.redAccent,
            child: const Icon(Icons.delete, color: Colors.white)),
        child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            margin: const EdgeInsets.all(0),
            elevation: 2,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(value: true, onChanged: onCheck),
                    Flexible(
                        child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultTextStyle(
                            style: Theme.of(context).textTheme.subtitle1!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            child: Text('Task: ${task.title}',
                                style: const TextStyle(
                                    decoration: null) // TODO isCompletedの時
                                ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultTextStyle(
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption!,
                              maxLines: 2,
                              child: Text('Description: ${task.content}')),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
