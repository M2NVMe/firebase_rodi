import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:firebase_rodi/Widgets/TaskFormWidget.dart';
import 'package:firebase_rodi/Widgets/TaskModal.dart';
import 'package:firebase_rodi/Widgets/adapter_notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UtamaPage extends StatelessWidget {
  UtamaPage({super.key});
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
              return GestureDetector(
                onTap: () {
                  showTaskDetails(context, task, crudController);
                },
                child: AdapterNotes(
                  task: task,
                  onToggleCompletion: () async {
                    await controller.toggleTaskCompletion(
                      task['id'],
                      task['completed'] ?? false,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (RoutePages.taskcreate != null) {
            Get.toNamed(RoutePages.taskcreate);
          } else {
            print("Route is null.");
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
