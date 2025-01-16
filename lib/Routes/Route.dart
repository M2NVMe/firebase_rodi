import 'package:firebase_rodi/Pages/Fragments/UtamaPage.dart';
import 'package:firebase_rodi/Pages/homePage.dart';
import 'package:firebase_rodi/Pages/loginPage.dart';
import 'package:firebase_rodi/Pages/registerPage.dart';
import 'package:get/get.dart';

class RoutePages {
  //tambahin initial nama pagesnya

  //misal =
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";
  static const taskviewlist = "/taskview";
}

class AppPages {
  static final pages = [
    //tambahin page pagenya disini
    GetPage(name: RoutePages.login, page: () => LoginPage()),
    GetPage(name: RoutePages.register, page: () => RegisterPage()),
    GetPage(name: RoutePages.home, page: () => HomePage()),
    GetPage(name: RoutePages.taskviewlist, page: () => CrudScreen()),
  ];
}
