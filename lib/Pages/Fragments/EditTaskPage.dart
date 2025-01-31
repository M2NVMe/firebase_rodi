import 'package:firebase_rodi/Widgets/custom_button.dart';
import 'package:firebase_rodi/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/EditTaskController.dart';

class EditTaskPage extends StatelessWidget {
  final EditTaskController editTaskController = Get.put(EditTaskController());
  final Crudcontroller crudController = Get.put(Crudcontroller());

  EditTaskPage({super.key}) {
    final task = Get.arguments as Map<String, dynamic>;
    print(task);
    editTaskController.initializeTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            Text(
              'Edit your task',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff313131),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildHeader("Task name"),
            const SizedBox(height: 4),
            CustomTextField(
              hintText: "Task...",
              controller: editTaskController.titleController,
              onChanged: (value) {
                editTaskController.titleController.text = value;
              },
              borderColor: Color(0xff9A9A9A),
              textColor: Color(0xff313131),
              maxLines: 1,
              borderRadius: 14,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            const SizedBox(height: 32),

            _buildHeader("Task Details"),
            const SizedBox(height: 4),
            CustomTextField(
              hintText: "Details...",
              textAlignVertical: TextAlignVertical.top,
              controller: editTaskController.descriptionController,
              onChanged: (value) {
                editTaskController.descriptionController.text = value;
              },
              borderColor: Color(0xff9A9A9A),
              textColor: Color(0xff313131),
              keyboardType: TextInputType.multiline,
              minLines: 7,
              maxLines: 7,
              borderRadius: 14,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            const SizedBox(height: 32),

            _buildHeader("Deadline"),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: "Due Date",
                    controller: editTaskController.dueDateController,
                    onChanged: (value) {},
                    borderColor: Color(0xff9A9A9A),
                    textColor: Color(0xff313131),
                    borderRadius: 14,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    prefixIcon: Transform.scale(
                      scale: 0.55,
                      child: Image.asset(
                        'lib/assets/images/date.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    readOnly: true,
                    onTap: () => editTaskController.pickDate(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    hintText: "Due Time",
                    controller: editTaskController.dueTimeController,
                    onChanged: (value) {},
                    borderColor: Color(0xff9A9A9A),
                    textColor: Color(0xff313131),
                    borderRadius: 14,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    prefixIcon: Transform.scale(
                      scale: 0.53,
                      child: Image.asset(
                        'lib/assets/images/time.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    readOnly: true,
                    onTap: () => editTaskController.pickTime(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 84),

            Center(
              child: CustomButton(
                text: "Update Task",
                backgroundColor: Color(0xff313131),
                textColor: Colors.white,
                textSize: 16,
                fontWeight: FontWeight.w600,
                buttonType: ButtonType.elevated,
                borderWidth: 0,
                borderColor: Colors.transparent,
                buttonWidth: 375,
                buttonHeight: 50,
                borderRadius: 14,
                onPressed: () async {
                  if (editTaskController.validateInputs()) {
                    bool success = await crudController.updateTask(
                      editTaskController.taskId!,
                      editTaskController.getUpdatedTaskData(),
                    );

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Task updated successfully!"),
                        ),
                      );
                      Get.back();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failed to update task. Try again."),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build the headers with consistent alignment
  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff4D4D4D), // You can change the color if needed
          ),
        ),
      ),
    );
  }
}
