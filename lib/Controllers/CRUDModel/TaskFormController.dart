import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TaskFormController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final dueTimeController = TextEditingController();
  final Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null);
  final crudController = Get.find<Crudcontroller>();

  bool validateInputs() {
    // Check empty fields
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required.",
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    if (dueDateController.text.isEmpty || dueTimeController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please select a due date and time.",
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    // Parse and validate date
    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(dueDateController.text);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Invalid date format.",
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    // Parse and validate time
    List<String> timeParts = dueTimeController.text.split(":");
    if (timeParts.length != 2) {
      Get.snackbar(
        "Error",
        "Invalid time format.",
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    try {
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      selectedDateTime.value = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        hour,
        minute,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Invalid time format.",
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    // Check if date is in the past
    if (selectedDateTime.value!.isBefore(DateTime.now())) {
      Get.snackbar(
        "Error",
        "Due date cannot be in the past.",
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    return true;
  }

  Future<bool> submitTask() async {
    if (!validateInputs()) {
      return false;
    }

    bool success = await crudController.addTask(
      titleController.text.trim(),
      descriptionController.text.trim(),
      selectedDateTime.value!,
    );

    if (success) {
      Get.snackbar(
        "Success",
        "Task added successfully!",
        snackPosition: SnackPosition.TOP,
      );
      Get.toNamed(RoutePages.home); // Navigate back
      return true;
    } else {
      Get.snackbar(
        "Error",
        "Failed to add task. Try again.",
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  void pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      if (selectedDateTime.value == null) {
        selectedDateTime.value = pickedDate;
      } else {
        selectedDateTime.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          selectedDateTime.value!.hour,
          selectedDateTime.value!.minute,
        );
      }

      dueDateController.text =
      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    }
  }

  void pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final date = selectedDateTime.value ?? DateTime.now();
      selectedDateTime.value = DateTime(
        date.year,
        date.month,
        date.day,
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