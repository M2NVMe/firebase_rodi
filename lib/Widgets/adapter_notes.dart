import 'package:cloud_firestore/cloud_firestore.dart'; // For Timestamp
import 'package:flutter/material.dart';

class AdapterNotes extends StatelessWidget {
  final Map<String, dynamic> task; // Specify the type as Map
  final VoidCallback onPressed;

  const AdapterNotes({
    Key? key,
    required this.task,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = task['title'] ?? 'No Title';
    final description = task['description'] ?? 'No Description';

    // Debugging: Print task details and raw duedate
    print('Task details: $task');
    print('Raw duedate value: ${task['duedate']}');

    // Handle 'duedate' field with different formats
    DateTime? dueDate;

    if (task['duedate'] is Timestamp) {
      dueDate = (task['duedate'] as Timestamp).toDate();
    } else if (task['duedate'] is String) {
      try {
        dueDate = DateTime.parse(task['duedate']);
      } catch (e) {
        print('Error parsing date string: ${task['duedate']}');
      }
    }

    final formattedDate = dueDate != null
        ? '${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}'
        : 'No Date';

    final formattedTime = dueDate != null
        ? '${dueDate.hour.toString().padLeft(2, '0')}:${dueDate.minute.toString().padLeft(2, '0')}'
        : 'No Time';

    return ListTile(
      title: Text(title),
      subtitle: Text('$description\n$formattedDate $formattedTime'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onPressed,
      ),
    );
  }
}
