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
          final data = doc.data() as Map<String, dynamic>;
          // Convert
          if (data.containsKey('duedate') && data['duedate'] is Timestamp) {
            data['duedate'] = (data['duedate'] as Timestamp).toDate();
          }
          return {'id': doc.id, ...data};
        }).toList();
      });
    }
  }

  Future<bool> addTask(
      String title, String description, DateTime duedate) async {
    final user = auth.currentUser;
    if (user != null) {
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
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
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
