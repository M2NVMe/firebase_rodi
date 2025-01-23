import 'package:firebase_rodi/Widgets/custom_button.dart';
import 'package:firebase_rodi/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:firebase_rodi/Controllers/CRUDModel/TaskFormController.dart';

class CreateTaskPage extends StatelessWidget {
  final TaskFormController taskFormController = Get.put(TaskFormController());
  final Crudcontroller crudController = Get.put(Crudcontroller());

  CreateTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Add a new task",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task name",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            CustomTextField(
              hintText: "Task...",
              onChanged: (value) {
                taskFormController.titleController.text = value;
              },
              controller: taskFormController.titleController,
              borderColor: Colors.grey,
              textColor: Colors.black,
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            Text(
              "Task Details",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            CustomTextField(
              hintText: "Details...",
              textAlignVertical: TextAlignVertical.top, // Align text to the top
              onChanged: (value) {
                taskFormController.descriptionController.text = value;
              },
              controller: taskFormController.descriptionController,
              borderColor: Colors.grey,
              textColor: Colors.black,
              keyboardType: TextInputType.multiline,// Fixed height
              minLines: 8, // Fixed number of lines based on height
              maxLines: 8, // Same as minLines for fixed height
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding
            ),
            const SizedBox(height: 16),
            Text(
              "Deadline",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: "Due Date",
                    onChanged: (value) {},
                    controller: taskFormController.dueDateController,
                    borderColor: Colors.grey,
                    textColor: Colors.black,
                    suffixIcon: Image.asset('lib/assets/images/date.png'),
                    readOnly: true,
                    onTap: () => taskFormController.pickDate(context),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: CustomTextField(
                    hintText: "Due Time",
                    onChanged: (value) {},
                    controller: taskFormController.dueTimeController,
                    borderColor: Colors.grey,
                    textColor: Colors.black,
                    suffixIcon: Image.asset('lib/assets/images/time.png', height: 50, width: 50,),
                    readOnly: true,
                    onTap: () => taskFormController.pickTime(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: CustomButton(
                text: "Add Task",
                backgroundColor: Colors.black,
                textColor: Colors.white,
                textSize: 16,
                buttonType: ButtonType.elevated,
                borderWidth: 0,
                borderColor: Colors.transparent,
                buttonWidth: double.infinity,
                buttonHeight: 50,
                borderRadius: 30,
                onPressed: taskFormController.submitTask,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
