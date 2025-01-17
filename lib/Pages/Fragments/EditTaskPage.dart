import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/CRUDModel/CRUDController.dart';
import '../../Controllers/CRUDModel/EditTaskController.dart';

class EditTaskPage extends StatelessWidget {
  final EditTaskController editTaskController = Get.put(EditTaskController());
  final Crudcontroller crudcontroller = Get.put(Crudcontroller());

  EditTaskPage({super.key}) {
    final task = Get.arguments as Map<String, dynamic>;
    print(task);
    editTaskController.initializeTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: editTaskController.titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: editTaskController.descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => editTaskController.pickDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: editTaskController.dueDateController,
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
                onTap: () => editTaskController.pickTime(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: editTaskController.dueTimeController,
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
                    if (editTaskController.validateInputs()) {
                      bool success = await crudcontroller.updateTask(
                        editTaskController.taskId!,
                        editTaskController.getUpdatedTaskData(),
                      );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Task updated successfully!")),
                        );
                        Get.back();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Failed to update task. Try again.")),
                        );
                      }
                    }
                  },
                  child: const Text("Update Task"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
