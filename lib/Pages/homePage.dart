import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Controllers/PageControllers/ChangePageController.dart';
import 'package:firebase_rodi/Pages/Fragments/CompletedTask.dart';
import 'package:firebase_rodi/Pages/Fragments/ProfilePage.dart';
import 'package:firebase_rodi/Pages/Fragments/UtamaPage.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/common/toast.dart';

class HomePage extends StatelessWidget {
  final Changepagecontroller changepagecontroller = Get.put(Changepagecontroller());
  List<Widget> Pages = [UtamaPage(), CompletedtaskPage(), Profilepage(),];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Pages[changepagecontroller.selectedindex.value],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // Drawer Header with placeholder text
              DrawerHeader(
                child: Text('Welcome', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
              // ListTile 1
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  changepagecontroller.changeMenu(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.check_box),
                title: Text('Completed tasks'),
                onTap: () {
                  changepagecontroller.changeMenu(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  changepagecontroller.changeMenu(2);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

//homePage
