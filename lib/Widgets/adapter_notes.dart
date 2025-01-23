import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

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
    final String title = task['title'] ?? 'No Title';
    final bool isCompleted = task['completed'] ?? false;

    // Format deadline date in the desired format "Mon, Jan 22 - 12:00 AM"
    final dueDate = task['duedate'] is DateTime
        ? DateFormat('EEE, MMM d - h:mm a').format(task['duedate'])
        : "No due date";

    return Opacity(
      opacity: isCompleted ? 0.7 : 1.0, // Decrease opacity if completed
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isCompleted
              ? const BorderSide(color: Color(0xFF313131), width: 1.5) // Border only if completed
              : BorderSide.none, // No border if unchecked
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
        elevation: 0.0, // Remove shadow
        color: isCompleted ? Colors.white : const Color(0xFFF2F2F2), // Background color
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Center checkbox vertically
            children: [
              GestureDetector(
                onTap: onToggleCompletion,
                child: Image.asset(
                  isCompleted
                      ? 'lib/assets/images/checkbox_checked.png' // Placeholder for checked checkbox
                      : 'lib/assets/images/checkbox_unchecked.png', // Placeholder for unchecked checkbox
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 20), // Margin between checkbox and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: const Color(0xFF313131), // Task name color
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dueDate,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF9A9A9A), // Deadline text color
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
