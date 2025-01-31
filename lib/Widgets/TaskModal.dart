import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

void showTaskDetails(
    BuildContext context, Map<String, dynamic> task, Crudcontroller crudController) {
  String formattedDate = "No due date";

  // Check if 'duedate' exists and is of type DateTime
  if (task['duedate'] is DateTime) {
    formattedDate =
        DateFormat('EEE, dd MMM - hh:mm a').format(task['duedate']);
  } else if (task['duedate'] is String) {
    try {
      final date = DateTime.parse(task['duedate']);
      formattedDate = DateFormat('EEE, dd MMM - hh:mm a').format(date);
    } catch (_) {
      formattedDate = "Invalid due date";
    }
  }

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed Header Section
                  Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset(
                            'lib/assets/images/back.png',
                            height: 24,
                            width: 24,
                          ),
                          tooltip: 'Back',
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Get.toNamed(
                                  RoutePages.taskedit,
                                  arguments: task,
                                );
                              },
                              icon: Image.asset(
                                'lib/assets/images/edit.png',
                                height: 24,
                                width: 24,
                              ),
                              tooltip: 'Edit',
                            ),
                            IconButton(
                              onPressed: () {
                                crudController.deleteTask(task['id']);
                                Navigator.pop(context);
                              },
                              icon: Image.asset(
                                'lib/assets/images/delete.png',
                                height: 24,
                                width: 24,
                              ),
                              tooltip: 'Delete',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Scrollable Content Section
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Task Section
                            Text(
                              'Task',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                color: const Color(0xFF9A9A9A),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              task['title'] ?? 'Unnamed Task',
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF313131),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Details Section
                            Text(
                              'Details',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                color: const Color(0xFF9A9A9A),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              task['description'] ??
                                  'No description provided.',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: const Color(0xFF313131),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Deadline Section
                            Text(
                              'Deadline',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                color: const Color(0xFF9A9A9A),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              formattedDate,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: const Color(0xFF313131),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}