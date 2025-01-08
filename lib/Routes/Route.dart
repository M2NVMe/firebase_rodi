import 'package:firebase_rodi/Pages/Login.dart';
import 'package:get/get.dart';

class RoutePages {
  //tambahin initial nama pagesnya


  //misal =
  static const login = "/login";
}

class AppPages{
  static final pages =  [
    //tambahin page pagenya disini
    GetPage(name: RoutePages.login, page: () => LoginPage()),

  ];
}