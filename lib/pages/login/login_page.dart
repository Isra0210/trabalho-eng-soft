import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/components/background_image_component.dart';
import 'package:hackday/pages/login/login_presenter.dart';
import 'package:hackday/utils/verify_user_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({required this.presenter, Key? key}) : super(key: key);

  static const route = '/login';

  final ILoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const BackgroundImageComponent(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () {
                    return widget.presenter.loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                Color.fromRGBO(57, 210, 192, 1),
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.white,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                primary: Colors.black,
                                elevation: 2,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              onPressed: () async {
                                if (FirebaseAuth.instance.currentUser != null) {
                                  () => Get.offNamed(VerifyUserPage.route);
                                } else {
                                  await widget.presenter.signInWithGoogle();
                                }
                              },
                              child: const Text(
                                "Iniciar jogo",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
