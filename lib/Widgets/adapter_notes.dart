import 'package:cloud_firestore/cloud_firestore.dart'; // For Timestamp
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class AdapterNotes extends StatelessWidget {
  final Map<String, dynamic> task;
  final VoidCallback onToggleCompletion;

  const AdapterNotes({
    Key? key,
    required this.task,
    required this.onToggleCompletion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = task['title'] ?? 'No Title';
    final description = task['description'] ?? 'No Description';
    final bool isCompleted = task['completed'] ?? false;

    // Handle 'duedate' field with different formats
    final dueDate = task['duedate'] is DateTime
        ? DateFormat('EEEE, MMM d, yyyy - h:mm a').format(task['duedate'])
        : "No due date";
    return Card(
      elevation: 2, // Subtle shadow for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white, // Modern white background for the card
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600, // Modern bold font
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54, // Softer description color
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Due: $dueDate",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.grey,
          ),
          onPressed: onToggleCompletion,
        ),
      ),
    );
  }
}
