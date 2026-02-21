import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color.fromARGB(255, 0, 0, 255);
  static const cardBackground = Colors.blue;
  static const textPrimary = Colors.white;
  static const textSecondary = Colors.white70;
  static const disabledBackground = Colors.grey;
}

class AppSizes {
  static const double cardBorderRadius = 12.0;
  static const double cardPadding = 12.0;
  static const double formPadding = 16.0;
  static const double formSpacing = 16.0;
  static const double buttonSpacing = 24.0;
  static const double listItemPadding = 8.0;

  static const double fontSizeTitle = 18.0;
  static const double fontSizeBody = 14.0;
  static const double fontSizeButton = 18.0;

  static const int detailMaxLines = 3;

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 32, vertical: 12);
}

class AppStrings {
  static const appTitle = 'TODOリスト';
  static const addTaskTitle = '新しいタスクを追加';
  static const taskTitleLabel = 'タスクのタイトル';
  static const taskTitleHint = '20文字以内で入力してください';
  static const taskDetailLabel = 'タスクの詳細';
  static const taskDetailHint = '入力してください';
  static const dueDateLabel = '期日';
  static const dueDateHint = '年/月/日';
  static const addTaskButton = 'タスクを追加';

  static const titleRequired = 'タイトルを入力してください';
  static const detailRequired = '詳細を入力してください';
  static const dateRequired = '期日を選択してください';
}
