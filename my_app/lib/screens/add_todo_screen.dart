import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';
import '../utils/date_formatter.dart';
import '../utils/validators.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key, required this.todoService});

  final TodoService todoService;

  @override
  AddTodoScreenState createState() => AddTodoScreenState();
}

class AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateFormValid);
    _detailController.addListener(_updateFormValid);
    _dateController.addListener(_updateFormValid);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateFormValid();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _updateFormValid() {
    setState(() {
      _isFormValid = _titleController.text.isNotEmpty &&
          _detailController.text.isNotEmpty &&
          _selectedDate != null;
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _dateController.text = DateFormatter.formatInput(date);
    });
  }

  void _saveTodo() async {
    if (_formKey.currentState!.validate()) {
      Todo newTodo = Todo(
        title: _titleController.text,
        detail: _detailController.text,
        dueDate: _selectedDate!,
      );

      final todos = await widget.todoService.getTodos();
      todos.add(newTodo);
      await widget.todoService.saveTodos(todos);

      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AddTodoAppBar(),
      body: _AddTodoForm(
        formKey: _formKey,
        titleController: _titleController,
        detailController: _detailController,
        dateController: _dateController,
        isFormValid: _isFormValid,
        onDateSelected: _onDateSelected,
        onSave: _saveTodo,
      ),
    );
  }
}

class _AddTodoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AddTodoAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text(AppStrings.addTaskTitle));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AddTodoForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController detailController;
  final TextEditingController dateController;
  final bool isFormValid;
  final Function(DateTime) onDateSelected;
  final VoidCallback onSave;

  const _AddTodoForm({
    required this.formKey,
    required this.titleController,
    required this.detailController,
    required this.dateController,
    required this.isFormValid,
    required this.onDateSelected,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.formPadding),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _TitleField(controller: titleController),
            const _FormSpacer(),
            _DetailField(controller: detailController),
            const _FormSpacer(),
            _DateField(
              controller: dateController,
              onDateSelected: onDateSelected,
            ),
            const _FormSpacer(height: AppSizes.buttonSpacing),
            _SubmitButton(
              isEnabled: isFormValid,
              onPressed: onSave,
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  final TextEditingController controller;

  const _TitleField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: AppStrings.taskTitleLabel,
        hintText: AppStrings.taskTitleHint,
      ),
      validator: Validators.titleValidator,
    );
  }
}

class _DetailField extends StatelessWidget {
  final TextEditingController controller;

  const _DetailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: AppStrings.taskDetailLabel,
        hintText: AppStrings.taskDetailHint,
      ),
      maxLines: AppSizes.detailMaxLines,
      validator: Validators.detailValidator,
    );
  }
}

class _DateField extends StatelessWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;

  const _DateField({
    required this.controller,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: AppStrings.dueDateLabel,
        hintText: AppStrings.dueDateHint,
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      validator: Validators.dateValidator,
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const _SubmitButton({
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? AppColors.primary : AppColors.disabledBackground.shade400,
      ),
      child: Text(
        AppStrings.addTaskButton,
        style: TextStyle(
          color: isEnabled ? AppColors.textPrimary : AppColors.disabledBackground,
          fontSize: AppSizes.fontSizeButton,
        ),
      ),
    );
  }
}

class _FormSpacer extends StatelessWidget {
  final double height;

  const _FormSpacer({this.height = AppSizes.formSpacing});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}