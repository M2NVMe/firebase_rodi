import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:firebase_rodi/Widgets/TaskFormWidget.dart';
import 'package:firebase_rodi/Widgets/TaskModal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CrudScreen extends StatelessWidget {
  CrudScreen({super.key});
  final Crudcontroller crudController = Get.put(Crudcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("To-Do list"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAllNamed(RoutePages.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GetX<Crudcontroller>(
        builder: (controller) {
          if (controller.tasks.isEmpty) {
            return const Center(child: Text("No tasks found."));
          }
          return ListView.builder(
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              final task = controller.tasks[index];
              final dueDate = task['duedate'] is DateTime
                  ? DateFormat('EEEE, MMM d, yyyy - h:mm a').format(task['duedate'])
                  : "No due date";
              return GestureDetector(
                onLongPress: () {
                  showTaskDetails(context, task, crudController);
                },
                child: Card(
                  child: ListTile(
                    title: Text(task['title'] ?? 'Unnamed Task'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task['description'] ?? 'No description provided.'),
                        const SizedBox(height: 4),
                        Text(
                          "Due: $dueDate",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await controller.deleteTask(task['id']);
                        print("Task deleted successfully!");
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: "Add Task",
            content: TaskForm(
              onSubmit: (title, description, time) {
                crudController.addTask(title, description, time);
                Get.back();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
