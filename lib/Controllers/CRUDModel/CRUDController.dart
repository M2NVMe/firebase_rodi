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
    }
  }

  void addTask(String title) async {
    final user = auth.currentUser;
    if (user != null) {
      await firestore.collection('tasks').doc(user.uid).collection('userTasks').add({
        'title': title,
        'createdAt': Timestamp.now(),
      });
    }
  }

  void deleteTask(String taskId) async {
    final user = auth.currentUser;
    if (user != null) {
      await firestore
          .collection('tasks')
          .doc(user.uid)
          .collection('userTasks')
          .doc(taskId)
          .delete();
    }
  }
}
