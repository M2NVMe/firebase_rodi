import 'package:firebase_rodi/Controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_rodi/Routes/Route.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Firebase Assignment App',
      initialRoute: RoutePages.splash,
      getPages: AppPages.pages,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),  // Primary color for app
        primaryColor: Color(0xff313131),  // Background color for the app
        appBarTheme: AppBarTheme(
          color: Colors.white,  // App bar color
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(background: Colors.white),

      ),
    );
  }
}
