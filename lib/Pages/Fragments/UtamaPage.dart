import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:firebase_rodi/Widgets/TaskModal.dart';
import 'package:firebase_rodi/Widgets/adapter_notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UtamaPage extends StatelessWidget {
  UtamaPage({super.key});
  final Crudcontroller crudController = Get.put(Crudcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
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
            Row(
              children: [
                Image.asset(
                  'lib/assets/images/logo.png',
                  height: 32,
                  width: 32,
                ),
                const SizedBox(width: 8),
                Text(
                  "Just do it.",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GetX<Crudcontroller>(
            builder: (controller) {
              final uncompletedTasks = controller.tasks
                  .where((task) => task['completed'] != true)
                  .toList();

              if (uncompletedTasks.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80), // Adjust this value to shift the content upward
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/assets/images/no_task.jpg', // Replace with your actual image asset path
                          height: 300, // Adjust the size as needed
                        ),
                        const SizedBox(height: 10), // Add spacing between the image and text
                        Text(
                          "No task yet",
                          style: GoogleFonts.inter(
                            fontSize: 23, // Larger font size for the first text
                            fontWeight: FontWeight.bold, // Bold font weight
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5), // Add spacing between the first and second text
                        Text(
                          "Adding your to-dos by tapping the plus button below",
                          textAlign: TextAlign.center, // Align text to the center
                          style: GoogleFonts.inter(
                            fontSize: 14, // Smaller font size for the second text
                            fontWeight: FontWeight.normal, // Normal font weight
                            color: Colors.grey[600], // Slightly lighter color for the second text
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }




              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80), // Adjust for floating button
                itemCount: uncompletedTasks.length,
                itemBuilder: (context, index) {
                  final task = uncompletedTasks[index];
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.8),
                    Colors.white,
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {
                    if (RoutePages.taskcreate != null) {
                      Get.toNamed(RoutePages.taskcreate);
                    } else {
                      print("Route is null.");
                    }
                  },
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.add, size: 30,),
                  elevation: 6, // Optional: you can adjust the elevation as needed
                  shape: CircleBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
