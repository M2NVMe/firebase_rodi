import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrudScreen extends StatelessWidget {
  final Crudcontroller crudController = Get.put(Crudcontroller());

  CrudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Tasks"),
        actions: [
          IconButton(
            onPressed: () {
              crudController.auth.signOut();
              Get.offAllNamed('/login'); // Navigate back to login
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (crudController.tasks.isEmpty) {
          return const Center(child: Text("No tasks found."));
        }
        return ListView.builder(
          itemCount: crudController.tasks.length,
          itemBuilder: (context, index) {
            final task = crudController.tasks[index];
            return ListTile(
              title: Text(task['title']),
              subtitle: Text(task['description']),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  crudController.deleteTask(task['id']);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: "Add Task",
            content: TaskForm(
              onSubmit: (title, description) {
                crudController.addTask(title, description);
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

class TaskForm extends StatelessWidget {
  final Function(String title, String description) onSubmit;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TaskForm({required this.onSubmit, super.key});

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
        ElevatedButton(
          onPressed: () {
            onSubmit(titleController.text.trim(), descriptionController.text.trim());
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
