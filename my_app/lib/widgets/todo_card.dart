import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/todo.dart';
import '../utils/date_formatter.dart';

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
    return _TodoCardContainer(
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
    );
  }
}

class _TodoCardContainer extends StatelessWidget {
  final Widget child;

  const _TodoCardContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.cardPadding),
        child: child,
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
        color: AppColors.textPrimary,
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
        _TodoTitle(title: todo.title),
        _TodoDetail(detail: todo.detail),
        _TodoDueDate(dueDate: todo.dueDate),
      ],
    );
  }
}

class _TodoTitle extends StatelessWidget {
  final String title;

  const _TodoTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: AppSizes.fontSizeTitle,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _TodoDetail extends StatelessWidget {
  final String detail;

  const _TodoDetail({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Text(
      detail,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: AppSizes.fontSizeBody,
      ),
    );
  }
}

class _TodoDueDate extends StatelessWidget {
  final DateTime dueDate;

  const _TodoDueDate({required this.dueDate});

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormatter.formatJapanese(dueDate),
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: AppSizes.fontSizeBody,
      ),
    );
  }
}