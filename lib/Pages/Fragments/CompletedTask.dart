import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Widgets/TaskModal.dart';
import 'package:firebase_rodi/Widgets/adapter_notes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // Import Google Fonts

class CompletedtaskPage extends StatelessWidget {
  const CompletedtaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Crudcontroller crudController = Get.put(Crudcontroller());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            // Burger icon
            IconButton(
              icon: Image.asset(
                'lib/assets/images/burger.png',
                height: 24,
                width: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(width: 8),
            // Logo
            Image.asset(
              'lib/assets/images/logo.png',
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 8),
            // Title Text
            Text(
              "Just do it.",
              style: GoogleFonts.inter( // Apply Inter font to the title
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: GetX<Crudcontroller>(
        builder: (controller) {
          // Filter for completed tasks only
          final completedTasks =
          controller.tasks.where((task) => task['completed'] == true).toList();

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
