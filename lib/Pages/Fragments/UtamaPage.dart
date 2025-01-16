import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:firebase_rodi/Widgets/TaskFormWidget.dart';
import 'package:firebase_rodi/Widgets/adapter_notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrudScreen extends StatelessWidget {
  CrudScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Crudcontroller crudController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Tasks"),
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
      body: Obx(() {
        if (crudController.tasks.isEmpty) {
          return const Center(child: Text("No tasks found."));
        }
        return ListView.builder(
          itemCount: crudController.tasks.length,
          itemBuilder: (context, index) {
            final task = crudController.tasks[index];
            return AdapterNotes(
              task: task,
              onPressed: () async {
                await crudController.deleteTask(task['id']);
                print("Task deleted successfully!");
              },
            );
          },
        );
      }),
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