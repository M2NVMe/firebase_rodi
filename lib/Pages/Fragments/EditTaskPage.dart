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
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: editTaskController.titleController,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            hintText: "Enter Task Title",
            hintStyle: TextStyle(color: Colors.black38),
            border: InputBorder.none,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: editTaskController.descriptionController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Write your task details here...",
                    hintStyle: TextStyle(color: Colors.black38),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => editTaskController.pickDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: editTaskController.dueDateController,
                          decoration: InputDecoration(
                            labelText: "Due Date",
                            labelStyle: const TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: const Icon(Icons.calendar_today,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => editTaskController.pickTime(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: editTaskController.dueTimeController,
                          decoration: InputDecoration(
                            labelText: "Due Time",
                            labelStyle: const TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: const Icon(Icons.access_time,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                            content: Text("Task updated successfully!"),
                          ),
                        );
                        Get.back();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Failed to update task. Try again."),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.grey.shade200,
                    elevation: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Update Task",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
