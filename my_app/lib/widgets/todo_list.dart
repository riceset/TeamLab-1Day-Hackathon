import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_card.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  final List<Todo> todos = _getSampleTodos();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => _TodoListItem(
        todo: todos[index],
        onToggle: () => print("test"),
      ),
    );
  }
}

class _TodoListItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onToggle;

  const _TodoListItem({
    required this.todo,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TodoCard(
        todo: todo,
        onToggle: onToggle,
      ),
    );
  }
}

List<Todo> _getSampleTodos() {
  return [
    Todo(
      title: '大学のレポート',
      detail: '心理学のレポートを2000字で書く',
      dueDate: DateTime(2025, 1, 15),
      isCompleted: false,
    ),
    Todo(
      title: '買い物',
      detail: '牛乳、パン、卵を買う',
      dueDate: DateTime(2025, 1, 10),
      isCompleted: true,
    ),
    Todo(
      title: 'アルバイト',
      detail: '金曜日のシフト、17時から21時',
      dueDate: DateTime(2025, 1, 12),
      isCompleted: false,
    ),
    Todo(
      title: '友達との約束',
      detail: '土曜日に映画を見に行く',
      dueDate: DateTime(2025, 1, 20),
      isCompleted: false,
    ),
    Todo(
      title: '図書館',
      detail: '借りた本を返却する（期限：来週火曜日）',
      dueDate: DateTime(2025, 1, 9),
      isCompleted: true,
    ),
  ];
}