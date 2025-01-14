import 'package:firebase_rodi/Pages/Login.dart';
import 'package:firebase_rodi/Pages/TestLogin.dart';
import 'package:firebase_rodi/Pages/UtamaPage.dart';
import 'package:get/get.dart';

class RoutePages {
  //tambahin initial nama pagesnya


  //misal =
  static const login = "/login";
  static const logintest = "/logintest";
  static const utama  = "/utama";
}

class AppPages{
  static final pages =  [
    //tambahin page pagenya disini
    GetPage(name: RoutePages.login, page: () => LoginPage()),
    GetPage(name: RoutePages.logintest, page: () => Testlogin()),
    GetPage(name: RoutePages.utama, page: () => CrudScreen()),
  ];
}