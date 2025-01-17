import 'package:firebase_rodi/Controllers/CRUDModel/EditTaskController.dart';
import 'package:get/get.dart';
import '../Controllers/CRUDModel/CRUDController.dart';
import '../Controllers/CRUDModel/TaskFormController.dart';

class CrudBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Crudcontroller());
    Get.lazyPut(() => TaskFormController());
    Get.lazyPut(() => EditTaskController());
  }
}
