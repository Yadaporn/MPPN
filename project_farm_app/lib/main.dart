import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_farm_app/screens/old/addclient.dart';
import 'package:project_farm_app/screens/old/dashboard.dart';
import 'package:project_farm_app/screens/farm.dart';
import 'package:project_farm_app/screens/login_page.dart';
import 'package:project_farm_app/screens/profile_page.dart';
import 'package:project_farm_app/screens/register_page.dart';
import 'package:project_farm_app/screens/repository/authentication_repository.dart';
import 'package:project_farm_app/screens/test.dart';
import 'package:project_farm_app/widgets/navbar_root.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home:  LoginPage(),
      initialRoute: '/',
      routes: {
        'login': (context) => LoginPage(),
        'register': (context) => RegisterPage(),
        'profile': (context) => ProfilePage(),
        'dashboard': (context) => DashBoardScreen(),
        'farm': (context) => FarmPage(),
        'navbarroot': (context) => NavBarRoots(),
        // 'test': (context) => TestPage(),
      },
    );
  }
}


