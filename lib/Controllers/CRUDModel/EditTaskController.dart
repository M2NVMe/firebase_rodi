import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final dueTimeController = TextEditingController();
  final Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null);
  String? taskId;

  /// Initialize task data
  void initializeTask(Map<String, dynamic> task) {
    print("Initializing task: $task"); // Add debug print
    taskId = task['id']; // Assuming the task map has 'id' field
    titleController.text = task['title'] ?? '';
    descriptionController.text = task['description'] ?? '';
    if (task['duedate'] != null) {
      DateTime dueDate = task['duedate'];
      dueDateController.text =
          "${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}";
      dueTimeController.text =
          "${dueDate.hour.toString().padLeft(2, '0')}:${dueDate.minute.toString().padLeft(2, '0')}";
      selectedDateTime.value = dueDate;
    }
  }

  /// Validate the input fields
  bool validateInputs() {
    if (titleController.text.isEmpty) {
      Get.snackbar("Error", "Title and description cannot be empty.");
      return false;
    }

    if (dueDateController.text.isEmpty || dueTimeController.text.isEmpty) {
      Get.snackbar("Error", "Please select a due date and time.");
      return false;
    }

    if (selectedDateTime.value == null ||
        selectedDateTime.value!.isBefore(DateTime.now())) {
      Get.snackbar("Error", "Due date cannot be in the past.");
      return false;
    }
    return true;
  }

  /// Prepare updated task data
  Map<String, dynamic> getUpdatedTaskData() {
    return {
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'duedate': selectedDateTime.value,
    };
  }

  /// Pick a date
  void pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate =
        selectedDateTime.value != null && selectedDateTime.value!.isAfter(now)
            ? selectedDateTime.value!
            : now;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      selectedDateTime.value = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        selectedDateTime.value?.hour ?? 0,
        selectedDateTime.value?.minute ?? 0,
      );

      dueDateController.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    }
  }

  /// Pick a time
  void pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final currentDate = selectedDateTime.value ?? DateTime.now();
      selectedDateTime.value = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      dueTimeController.text =
          "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    dueTimeController.dispose();
    super.onClose();
  }
}
