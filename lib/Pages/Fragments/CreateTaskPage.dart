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
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: taskformcontroller.titleController,
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
                  controller: taskformcontroller.descriptionController,
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
                      onTap: () => taskformcontroller.pickDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: taskformcontroller.dueDateController,
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
                      onTap: () => taskformcontroller.pickTime(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: taskformcontroller.dueTimeController,
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
                    // Validate inputs
                    if (taskformcontroller.titleController.text.isEmpty ||
                        taskformcontroller.descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("All fields are required.")),
                      );
                      return;
                    }

                    if (taskformcontroller.dueDateController.text.isEmpty ||
                        taskformcontroller.dueTimeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Please select a due date and time.")),
                      );
                      return;
                    }

                    // Parse date and time from controllers
                    DateTime? parsedDate;
                    try {
                      parsedDate = DateTime.parse(
                          taskformcontroller.dueDateController.text);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid date format.")),
                      );
                      return;
                    }

                    List<String> timeParts =
                        taskformcontroller.dueTimeController.text.split(":");
                    if (timeParts.length != 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid time format.")),
                      );
                      return;
                    }

                    int hour = int.parse(timeParts[0]);
                    int minute = int.parse(timeParts[1]);

                    // Combine date and time
                    final combinedDateTime = DateTime(
                      parsedDate.year,
                      parsedDate.month,
                      parsedDate.day,
                      hour,
                      minute,
                    );

                    // Ensure the date is in the future
                    if (combinedDateTime.isBefore(DateTime.now())) {
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
                      combinedDateTime,
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
                      Icon(Icons.add, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Create Task",
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
