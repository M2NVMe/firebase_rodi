import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/common/toast.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               FirebaseAuth.instance.signOut();
               showToast(message: "Successfully signed out.");
               Get.toNamed(RoutePages.login);
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

//homePage