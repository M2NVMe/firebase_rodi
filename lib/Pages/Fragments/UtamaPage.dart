import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:firebase_rodi/Widgets/TaskFormWidget.dart';
import 'package:firebase_rodi/Widgets/adapter_notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrudScreen extends StatelessWidget {
  CrudScreen({super.key});

  // Initialize the controller at the class level
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
      body: GetX<Crudcontroller>( // Changed from Obx to GetX for better lifecycle management
          builder: (controller) {
            if (controller.tasks.isEmpty) {
              return const Center(child: Text("No tasks found."));
            }
            return ListView.builder(
              itemCount: controller.tasks.length,
              itemBuilder: (context, index) {
                final task = controller.tasks[index];
                return AdapterNotes(
                  task: task,
                  onPressed: () async {
                    await controller.deleteTask(task['id']);
                    print("Task deleted successfully!");
                  },
                );
              },
            );
          }
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