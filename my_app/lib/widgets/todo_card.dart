import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onToggle;

  const TodoCard({
    super.key,
    required this.todo,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _TodoCheckbox(
              isCompleted: todo.isCompleted,
              onPressed: onToggle,
            ),
            Expanded(
              child: _TodoInfo(todo: todo),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodoCheckbox extends StatelessWidget {
  final bool isCompleted;
  final VoidCallback? onPressed;

  const _TodoCheckbox({
    required this.isCompleted,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}

class _TodoInfo extends StatelessWidget {
  final Todo todo;

  const _TodoInfo({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          todo.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          todo.detail,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        Text(
          DateFormat('M月d日(E)', 'ja').format(todo.dueDate),
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}