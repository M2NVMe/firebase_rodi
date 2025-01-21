import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Widgets/TaskModal.dart';
import 'package:firebase_rodi/Widgets/adapter_notes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CompletedtaskPage extends StatelessWidget {
  const CompletedtaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Crudcontroller crudController = Get.put(Crudcontroller());
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks"), automaticallyImplyLeading: false,),
      body: GetX<Crudcontroller>(
        builder: (controller) {
          // Filter for completed tasks only
          final completedTasks = controller.tasks.where((task) => task['completed'] == true).toList();

          if (completedTasks.isEmpty) {
            return const Center(child: Text("No completed tasks found."));
          }
          return ListView.builder(
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              final task = completedTasks[index];
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
    );
  }
}
