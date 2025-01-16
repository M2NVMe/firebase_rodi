import 'package:firebase_rodi/Controllers/CRUDModel/TaskFormController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TaskForm extends StatelessWidget {
  final Function(String title, String description, DateTime dueDateTime) onSubmit;
  final TaskFormController controller = Get.put(TaskFormController());

  TaskForm({required this.onSubmit, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller.titleController,
          decoration: const InputDecoration(labelText: "Title"),
        ),
        TextField(
          controller: controller.descriptionController,
          decoration: const InputDecoration(labelText: "Description"),
        ),
        GestureDetector(
          onTap: () => controller.pickDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: controller.dueDateController,
              decoration: const InputDecoration(
                labelText: "Due Date",
                hintText: "Pick a date",
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => controller.pickTime(context),
          child: AbsorbPointer(
            child: TextField(
              controller: controller.dueTimeController,
              decoration: const InputDecoration(
                labelText: "Due Time",
                hintText: "Pick a time",
              ),
            ),
          ),
        ),
        Obx(() => ElevatedButton(
          onPressed: () {
            if (controller.selectedDateTime.value == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Please select a due date and time")),
              );
              return;
            }

            if (controller.selectedDateTime.value!.isBefore(DateTime.now())) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Due date cannot be in the past")),
              );
              return;
            }

            onSubmit(
              controller.titleController.text.trim(),
              controller.descriptionController.text.trim(),
              controller.selectedDateTime.value!,
            );
          },
          child: const Text("Submit"),
        )),
      ],
    );
  }
}