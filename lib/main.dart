import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/login/login_page.dart';
import 'package:hackday/presenters/login/login_binding.dart';

import 'pages/levels/first_level/first_level_page.dart';
import 'presenters/levels/levels_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void handleUser(Stream<User?> stream) {
      stream.listen(
        (user) async {
          if (user == null) {
            Get.offAllNamed(LoginPage.route);
          } else {
            if (Get.rawRoute!.settings.name != FirstLevelPage.route) {
              Get.offAllNamed(FirstLevelPage.route);
            }
          }
        },
      );
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginPage.route,
      onInit: () {
        handleUser(FirebaseAuth.instance.authStateChanges());
      }, 
      onReady: () {
        handleUser(FirebaseAuth.instance.authStateChanges());
      },
      getPages: [
        GetPage(
          binding: LoginBinding(),
          name: LoginPage.route,
          page: () => const LoginPage(),
        ),
        GetPage(
          binding: LevelsBinding(),
          name: FirstLevelPage.route,
          page: () => const FirstLevelPage(),
        ),
      ],
    );
  }
}
