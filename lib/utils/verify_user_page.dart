import 'package:flutter/material.dart';
import 'package:hackday/admin/home/home_page.dart';
import 'package:hackday/pages/levels/first_level/first_level_page.dart';
import 'package:hackday/pages/levels/levels_presenter.dart';
import 'package:hackday/pages/login/login_page.dart';

import '../pages/login/login_presenter.dart';

class VerifyUserPage extends StatelessWidget {
  const VerifyUserPage({
    required this.loginPresenter,
    required this.levelsPresenter,
    Key? key,
  }) : super(key: key);

  static const route = '/verifying-user';
  final ILoginPresenter loginPresenter;
  final ILevelsPresenter levelsPresenter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: FutureBuilder<Map<String, dynamic>?>(
          future: loginPresenter.verifyUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0XFF1e224c)),
                ),
              );
            }

            if (snapshot.data == null) {
              return LoginPage(
                presenter: loginPresenter,
              );
            }

            if (snapshot.hasData) {
              final user = snapshot.data!;

              if (user['isAdmin']) {
                return HomePage(
                  presenter: levelsPresenter,
                );
              } else {
                return const FirstLevelPage();
              }
            }

            return Center(
              child: Text('${snapshot.data}'),
            );
          },
        ),
      ),
    );
  }
}
