import 'package:get/get.dart';
import '../Pages/Fragments/CreateTaskPage.dart';
import '../Pages/Fragments/UtamaPage.dart';
import '../Pages/homePage.dart';
import '../Pages/loginPage.dart';
import '../Pages/registerPage.dart';
import '../Bindings/CRUDBindings.dart';

class RoutePages {
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";
  static const taskviewlist = "/taskview";
  static const taskcreate = "/taskcreate";
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
        page: () => CrudScreen(),
        binding: CrudBinding()),
    GetPage(
        name: RoutePages.taskcreate,
        page: () => CreateTaskPage(),
        binding: CrudBinding()),
  ];
}
