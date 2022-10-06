import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/finish/feedback_page.dart';
import 'package:hackday/pages/levels/levels_presenter.dart';
import 'package:hackday/pages/levels/second_level/second_level_page.dart';
import 'package:hackday/pages/login/login_page.dart';
import 'package:hackday/pages/login/login_presenter.dart';
import 'package:hackday/presenters/levels/getx_levels_presenter.dart';
import 'package:hackday/presenters/login/getx_login_presenter.dart';
import 'package:hackday/utils/verify_user_page.dart';

import 'admin/home/home_page.dart';
import 'pages/levels/first_level/first_level_page.dart';
import 'pages/levels/third_level/third_level.dart';
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
            if (Get.rawRoute?.settings.name != VerifyUserPage.route) {
              Get.offAllNamed(VerifyUserPage.route);
            }
          }
        },
      );
    }

    final ILevelsPresenter levelsPresenter =
        Get.put<ILevelsPresenter>(GetXLevelsPresenter());
    final ILoginPresenter loginPresenter =
        Get.put<ILoginPresenter>(GetXLoginPresenter());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: FirstLevelPage.route,
      onInit: () {
        handleUser(FirebaseAuth.instance.authStateChanges());
      },
      onReady: () {
        handleUser(FirebaseAuth.instance.authStateChanges());
      },
      getPages: [
        GetPage(
          name: LoginPage.route,
          page: () => LoginPage(presenter: loginPresenter),
        ),
        GetPage(
          binding: LevelsBinding(),
          name: FirstLevelPage.route,
          page: () => const FirstLevelPage(),
        ),
        GetPage(
          binding: LevelsBinding(),
          name: SecondLevelPage.route,
          page: () => SecondLevelPage(levelsPresenter: levelsPresenter),
        ),
        GetPage(
          binding: LevelsBinding(),
          name: ThirdLevelPage.route,
          page: () => ThirdLevelPage(presenter: levelsPresenter),
        ),
        GetPage(
          binding: LevelsBinding(),
          name: FeedbackPage.route,
          page: () => const FeedbackPage(),
        ),
   
        GetPage(
          binding: LevelsBinding(),
          name: HomePage.route,
          page: () => HomePage(presenter: levelsPresenter),
        ),
        GetPage(
          binding: LevelsBinding(),
          name: VerifyUserPage.route,
          page: () => VerifyUserPage(
            loginPresenter: loginPresenter,
            levelsPresenter: levelsPresenter,
          ),
        ),
      ],
    );
  }
}
