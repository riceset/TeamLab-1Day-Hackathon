import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF5C6BC0);
  static const primaryDark = Color(0xFF3949AB);
  static const accent = Color(0xFF7E57C2);
  static const cardBackground = Color(0xFF5C6BC0);
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFE8EAF6);
  static const disabledBackground = Colors.grey;
  static const background = Color(0xFFF5F5F5);
  static const emptyStateText = Color(0xFF9E9E9E);
  static const deleteBackground = Color(0xFFEF5350);
  static const deleteIcon = Colors.white;
}

class AppSizes {
  static const double cardBorderRadius = 16.0;
  static const double cardPadding = 16.0;
  static const double cardElevation = 2.0;
  static const double formPadding = 16.0;
  static const double formSpacing = 16.0;
  static const double buttonSpacing = 24.0;
  static const double listItemPadding = 12.0;
  static const double buttonBorderRadius = 12.0;

  static const double fontSizeTitle = 18.0;
  static const double fontSizeBody = 14.0;
  static const double fontSizeButton = 16.0;
  static const double fontSizeEmptyState = 16.0;

  static const double iconSize = 28.0;
  static const double textSpacing = 4.0;

  static const int detailMaxLines = 3;

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 32, vertical: 16);
  static const EdgeInsets cardContentPadding = EdgeInsets.all(16.0);
}

class AppStrings {
  static const appTitle = 'To-Doリスト';
  static const addTaskTitle = '新しいタスクを追加';
  static const taskTitleLabel = 'タスクのタイトル';
  static const taskDetailLabel = 'タスクの詳細';
  static const taskDetailHint = '入力してください';
  static const dueDateLabel = '期日';
  static const dueDateHint = '年/月/日';
  static const addTaskButton = 'タスクを追加';

  static const titleRequired = 'タイトルを入力してください';
  static const detailRequired = '詳細を入力してください';
  static const dateRequired = '期日を選択してください';
}
