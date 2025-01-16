import 'package:firebase_rodi/Controllers/CRUDModel/CRUDController.dart';
import 'package:get/get.dart';

class CrudBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crudcontroller());
  }
}