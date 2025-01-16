import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/CRUDModel/TaskFormController.dart';

class CreateTaskPage extends StatelessWidget {
  final TaskFormController taskformcontroller = Get.put(TaskFormController());
  final Crudcontroller crudcontroller = Get.put(Crudcontroller());

  CreateTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: taskformcontroller.titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: taskformcontroller.descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => taskformcontroller.pickDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: taskformcontroller.dueDateController,
                    decoration: const InputDecoration(
                      labelText: "Due Date",
                      hintText: "Pick a date",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => taskformcontroller.pickTime(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: taskformcontroller.dueTimeController,
                    decoration: const InputDecoration(
                      labelText: "Due Time",
                      hintText: "Pick a time",
                      suffixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate inputs
                    if (taskformcontroller.titleController.text.isEmpty ||
                        taskformcontroller.descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("All fields are required.")),
                      );
                      return;
                    }

                    if (taskformcontroller.selectedDateTime.value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Please select a due date and time.")),
                      );
                      return;
                    }

                    if (taskformcontroller.selectedDateTime.value!
                        .isBefore(DateTime.now())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Due date cannot be in the past.")),
                      );
                      return;
                    }

                    // Add task and show snackbar based on success
                    bool success = await crudcontroller.addTask(
                      taskformcontroller.titleController.text.trim(),
                      taskformcontroller.descriptionController.text.trim(),
                      taskformcontroller.selectedDateTime.value!,
                    );

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Task added successfully!")),
                      );

                      // Navigate back to the previous screen
                      Get.back();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Failed to add task. Try again.")),
                      );
                    }
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
