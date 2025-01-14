import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Crudcontroller extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> tasks = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }

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
          return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
        }).toList();
      });
    } else {
      print("User is null, cannot load tasks.");
    }
  }

  void addTask(String title, String description, DateTime duedate) async {
    final user = auth.currentUser;
    if (user != null) {
      if (duedate.isBefore(DateTime.now())) {
        Get.snackbar('Error', 'Due date cannot be in the past.');
        return;
      }
      try {
        await firestore
            .collection('tasks')
            .doc(user.uid)
            .collection('userTasks')
            .add({
          'title': title,
          'description': description,
          'duedate': duedate,
          'completed': false,
          'createdAt': Timestamp.now(),
        });
        Get.snackbar('Success', 'Task added successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to add task: $e');
      }
    } else {
      Get.snackbar('Error', 'User not authenticated');
    }
  }

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

  Future<void> toggleTaskCompletion(String taskId, bool currentStatus) async {
    await updateTask(taskId, {'completed': !currentStatus});
  }
}
