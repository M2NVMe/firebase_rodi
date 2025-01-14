import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
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
              FirebaseAuth.instance.signOut();
              Get.offAllNamed(RoutePages.login); // Navigate back to login
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

class TaskForm extends StatefulWidget {
  final Function(String title, String description, DateTime dueDateTime) onSubmit;

  const TaskForm({required this.onSubmit, Key? key}) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDateTime;

  void _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      if (selectedDateTime == null) {
        selectedDateTime = pickedDate;
      } else {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          selectedDateTime!.hour,
          selectedDateTime!.minute,
        );
      }
      setState(() {});
    }
  }

  void _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedDateTime != null
          ? TimeOfDay.fromDateTime(selectedDateTime!)
          : TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final date = selectedDateTime ?? DateTime.now();
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      setState(() {});
    }
  }

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
        GestureDetector(
          onTap: () => _pickDate(context),
          child: AbsorbPointer(
            child: TextField(
              decoration: InputDecoration(
                labelText: "Due Date",
                hintText: selectedDateTime != null
                    ? "${selectedDateTime!.year}-${selectedDateTime!.month.toString().padLeft(2, '0')}-${selectedDateTime!.day.toString().padLeft(2, '0')}"
                    : "Pick a date",
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _pickTime(context),
          child: AbsorbPointer(
            child: TextField(
              decoration: InputDecoration(
                labelText: "Due Time",
                hintText: selectedDateTime != null
                    ? "${selectedDateTime!.hour.toString().padLeft(2, '0')}:${selectedDateTime!.minute.toString().padLeft(2, '0')}"
                    : "Pick a time",
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedDateTime != null) {
              widget.onSubmit(
                titleController.text.trim(),
                descriptionController.text.trim(),
                selectedDateTime!,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please select a due date and time")),
              );
            }
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
