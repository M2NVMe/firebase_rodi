import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:firebase_rodi/Widgets/TaskFormWidget.dart';
import 'package:firebase_rodi/Widgets/TaskModal.dart';
import 'package:firebase_rodi/Widgets/adapter_notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';  // Import Google Fonts
import 'package:intl/intl.dart';

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
            // Logo and text
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
                  style: GoogleFonts.inter( // Use Google Fonts directly
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: GetX<Crudcontroller>(
        builder: (controller) {
          // Filter for uncompleted tasks
          final uncompletedTasks =
          controller.tasks.where((task) => task['completed'] != true).toList();

          if (uncompletedTasks.isEmpty) {
            return const Center(child: Text("No tasks found."));
          }
          return ListView.builder(
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
