import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CRUDutama extends StatelessWidget {
  final Crudcontroller controller = Get.put(Crudcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.addTask("New Task", "Description for the new task");
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.tasks.isEmpty) {
          return const Center(child: Text("No tasks available"));
        }
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];
            return ListTile(
              title: Text(task['title']),
              subtitle: Text(task['description']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      task['completed'] ? Icons.check_box : Icons.check_box_outline_blank,
                      color: task['completed'] ? Colors.green : null,
                    ),
                    onPressed: () {
                      controller.toggleTaskCompletion(task['id'], task['completed']);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      controller.deleteTask(task['id']);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
