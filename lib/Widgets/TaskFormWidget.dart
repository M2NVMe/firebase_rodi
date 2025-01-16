import 'package:firebase_rodi/Controllers/CRUDModel/TaskFormController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final Function(String title, String description, DateTime dueDateTime)
  onSubmit;

  const TaskForm({required this.onSubmit, super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController dueTimeController = TextEditingController();
  DateTime? selectedDateTime;

  void _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(), // Prevent past date selection
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      if (selectedDateTime == null) {
        selectedDateTime = pickedDate;
      } else {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          selectedDateTime!.hour,
          selectedDateTime!.minute,
        );
      }

      // Update the Due Date TextField
      dueDateController.text =
      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      setState(() {});
    }
  }

  void _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Prevent past time selection
    );

    if (pickedTime != null) {
      final date = selectedDateTime ?? DateTime.now();
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Update the Due Time TextField
      dueTimeController.text =
      "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: "Title"),
        ),
        TextField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: "Description"),
        ),
        GestureDetector(
          onTap: () => _pickDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: dueDateController,
              decoration: const InputDecoration(
                labelText: "Due Date",
                hintText: "Pick a date",
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _pickTime(context),
          child: AbsorbPointer(
            child: TextField(
              controller: dueTimeController,
              decoration: const InputDecoration(
                labelText: "Due Time",
                hintText: "Pick a time",
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedDateTime == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Please select a due date and time")),
              );
              return;
            }

            if (selectedDateTime!.isBefore(DateTime.now())) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Due date cannot be in the past")),
              );
              return;
            }

            widget.onSubmit(
              titleController.text.trim(),
              descriptionController.text.trim(),
              selectedDateTime!,
            );
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}