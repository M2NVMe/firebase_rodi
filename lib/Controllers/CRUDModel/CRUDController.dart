import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Crudcontroller extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Observable list to hold tasks
  RxList<Map<String, dynamic>> tasks = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTasks(); // Automatically load tasks when the controller initializes
  }

  // Load tasks in real-time
  void _loadTasks() {
    final user = auth.currentUser;
    if (user != null) {
      firestore
          .collection('tasks')
          .doc(user.uid)
          .collection('userTasks')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        tasks.value = snapshot.docs.map((doc) {
          return {
            'id': doc.id, // Add task ID for easier updates/deletes
            ...doc.data() as Map<String, dynamic>
          };
        }).toList();
      });
    }
  }

  // Add a new task
  Future<void> addTask(String title, String description) async {
    final user = auth.currentUser;
    if (user != null) {
      await firestore.collection('tasks').doc(user.uid).collection('userTasks').add({
        'title': title,
        'description': description,
        'completed': false, // Default value
        'createdAt': Timestamp.now(),
      });
      Get.snackbar("Success", "Task added successfully!");
    } else {
      Get.snackbar("Error", "User not logged in!");
    }
  }

  // Update an existing task
  Future<void> updateTask(String taskId, Map<String, dynamic> updates) async {
    final user = auth.currentUser;
    if (user != null) {
      await firestore
          .collection('tasks')
          .doc(user.uid)
          .collection('userTasks')
          .doc(taskId)
          .update(updates);
      Get.snackbar("Success", "Task updated successfully!");
    } else {
      Get.snackbar("Error", "User not logged in!");
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    final user = auth.currentUser;
    if (user != null) {
      await firestore
          .collection('tasks')
          .doc(user.uid)
          .collection('userTasks')
          .doc(taskId)
          .delete();
      Get.snackbar("Success", "Task deleted successfully!");
    } else {
      Get.snackbar("Error", "User not logged in!");
    }
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(String taskId, bool currentStatus) async {
    await updateTask(taskId, {'completed': !currentStatus});
  }
}
