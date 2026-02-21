import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';
import '../widgets/todo_card.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.todoService});

  final TodoService todoService;

  @override
  State<TodoList> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<Todo> _todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await widget.todoService.getTodos();
    setState(() {
      _todos = todos;
      _isLoading = false;
    });
  }

  void addTodo(Todo newTodo) async {
    setState(() => _todos.add(newTodo));
    await widget.todoService.saveTodos(_todos);
  }

  Future<void> _deleteTodo(Todo todo) async {
    setState(() => _todos.removeWhere((t) => t.id == todo.id));
    await widget.todoService.saveTodos(_todos);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const _LoadingView()
        : _TodoListContent(
            todos: _todos,
            onDeleteTodo: _deleteTodo,
          );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _TodoListContent extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo) onDeleteTodo;

  const _TodoListContent({
    required this.todos,
    required this.onDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const _EmptyState();
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => _TodoListItem(
        todo: todos[index],
        onToggle: () => onDeleteTodo(todos[index]),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 64,
            color: AppColors.emptyStateText,
          ),
          const SizedBox(height: 16),
          Text(
            'タスクがありません',
            style: TextStyle(
              fontSize: AppSizes.fontSizeEmptyState,
              color: AppColors.emptyStateText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '右下のボタンから追加できます',
            style: TextStyle(
              fontSize: AppSizes.fontSizeBody,
              color: AppColors.emptyStateText,
            ),
          ),
        ],
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
      padding: const EdgeInsets.all(AppSizes.listItemPadding),
      child: Dismissible(
        key: Key(todo.id),
        direction: DismissDirection.endToStart,
        background: _buildSwipeBackground(),
        confirmDismiss: (direction) async {
          return await _showDeleteConfirmation(context);
        },
        onDismissed: (direction) {
          if (onToggle != null) {
            onToggle!();
          }
        },
        child: TodoCard(
          todo: todo,
          onToggle: onToggle,
        ),
      ),
    );
  }

  Widget _buildSwipeBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: AppColors.deleteBackground,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
      ),
      child: const Icon(
        Icons.delete,
        color: AppColors.deleteIcon,
        size: 32,
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('タスクを削除'),
        content: Text('「${todo.title}」を削除しますか？'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.deleteBackground,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );
  }
}