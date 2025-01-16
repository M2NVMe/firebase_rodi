import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/CRUDModel/CRUDController.dart';
import '../../Routes/Route.dart';
import '../../Widgets/adapter_notes.dart';

class UtamaPage extends StatelessWidget {
  final Crudcontroller crudController = Get.put(Crudcontroller());

  UtamaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("To-Do List"),
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
              return AdapterNotes(
                task: task,
                onPressed: () async {
                  await controller.deleteTask(task['id']);
                  print("Task deleted successfully!");
                },
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
