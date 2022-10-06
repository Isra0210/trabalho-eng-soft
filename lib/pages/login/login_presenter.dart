import 'package:firebase_auth/firebase_auth.dart';

abstract class ILoginPresenter {
  bool get loading;
  set loading(bool value);

  UserCredential? get user;
  set user(UserCredential? value);

  Future<UserCredential?> signInWithGoogle();

  Future<Map<String, dynamic>?>? verifyUserProfile();
}
