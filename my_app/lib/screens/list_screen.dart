import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/todo_service.dart';
import '../widgets/todo_list.dart';
import 'add_todo_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, required this.todoService});

  final TodoService todoService;

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  Key _todoListKey = UniqueKey();

  void _navigateToAddScreen() async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoScreen(todoService: widget.todoService),
      ),
    );

    if (updated == true) {
      setState(() {
        _todoListKey = UniqueKey();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _ListScreenAppBar(),
      body: TodoList(
        key: _todoListKey,
        todoService: widget.todoService,
      ),
      floatingActionButton: _AddTodoButton(onPressed: _navigateToAddScreen),
    );
  }
}

class _ListScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ListScreenAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text(AppStrings.appTitle));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AddTodoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddTodoButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}