import 'package:amaxi/pages/driver_dashboard.dart';
import 'package:amaxi/pages/driver_login.dart';
import 'package:amaxi/pages/home_page.dart';
import 'package:amaxi/pages/home_page_driver.dart';
import 'package:amaxi/pages/main_login.dart';
import 'package:amaxi/pages/main_login_driver.dart';
import 'package:amaxi/pages/main_screen.dart';
import 'package:amaxi/pages/user_book.dart';
import 'package:amaxi/pages/user_dashboard.dart';
import 'package:amaxi/pages/user_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'user_dashboard',
    routes: {
      'user_login': (context) => userLogin(), // user register
      'driver_login': (context) => driverLogin(), // driver register
      'main_login': (context) => loginAll(), // user login
      'home_screen': (context) => HomePage(),
      'driver_login_main': (context) => driverLoginMain(), // driver login
      'user_dashboard': (context) => userDashboard(),
      'driver_dashboard': (context) => driverDashboard(),
      'user_book': (context) => userBook(),
      'home_screen_driver': (context) => homePageDriver(),
      'main_screen': (context) => home(),
    },
  ));
}
