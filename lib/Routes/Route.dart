import 'package:firebase_rodi/Pages/Fragments/CompletedTask.dart';
import 'package:firebase_rodi/Pages/Fragments/EditTaskPage.dart';
import 'package:get/get.dart';
import '../Pages/Fragments/CreateTaskPage.dart';
import '../Pages/Fragments/UtamaPage.dart';
import '../Pages/SplashScreen.dart';
import '../Pages/homePage.dart';
import '../Pages/loginPage.dart';
import '../Pages/registerPage.dart';
import '../Bindings/CRUDBindings.dart';

class RoutePages {
  static const splash = "/splash";
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";
  static const taskviewlist = "/taskview";
  static const taskcreate = "/taskcreate";
  static const taskedit = "/taskedit";
  static const completedtask = "/completedtasks";
}

class AppPages {
  static final pages = [
    GetPage(name: RoutePages.login, page: () => LoginPage()),
    GetPage(name: RoutePages.register, page: () => RegisterPage()),
    GetPage(name: RoutePages.home, page: () => HomePage(), bindings: [
      CrudBinding(),
    ]),
    GetPage(
        name: RoutePages.taskviewlist,
        page: () => UtamaPage(),
        binding: CrudBinding()),
    GetPage(
        name: RoutePages.taskcreate,
        page: () => CreateTaskPage(),
        binding: CrudBinding()),
    GetPage(
        name: RoutePages.taskedit,
        page: () => EditTaskPage(),
        binding: CrudBinding()),
    GetPage(
        name: RoutePages.completedtask,
        page: () => CompletedtaskPage(),
        binding: CrudBinding()),
    GetPage(
        name: RoutePages.splash,
        page: () => SplashScreen()),
  ];
}
