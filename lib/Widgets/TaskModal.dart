import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Pages/Fragments/EditTaskPage.dart'; // Import the intl package

void showTaskDetails(BuildContext context, Map<String, dynamic> task,
    Crudcontroller crudController) {
  String formattedDate = "No due date";

  // Check if 'duedate' exists and is of type DateTime
  if (task['duedate'] is DateTime) {
    formattedDate =
        DateFormat('EEEE, MMM d, yyyy - h:mm a').format(task['duedate']);
  } else if (task['duedate'] is String) {
    try {
      final date = DateTime.parse(task['duedate']);
      formattedDate = DateFormat('EEEE, MMM d, yyyy - h:mm a').format(date);
    } catch (_) {
      formattedDate = "Invalid due date";
    }
  }

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['title'] ?? 'Unnamed Task',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              task['description'] ?? 'No description provided.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              "Due: $formattedDate",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    crudController.deleteTask(task['id']);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    print(
                        task); // Make sure 'task' is a Map with the correct data

                    // Pass the task to the next page using Get.toNamed
                    Get.toNamed(
                      RoutePages.taskedit,
                      arguments: task, // You can directly pass the task
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
