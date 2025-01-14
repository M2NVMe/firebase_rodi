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

    // Check if 'duedate' is a valid Timestamp and convert it to DateTime
    final dueDate = task['duedate'] is Timestamp
        ? (task['duedate'] as Timestamp).toDate()
        : null;

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
