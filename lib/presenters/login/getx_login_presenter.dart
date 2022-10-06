import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/levels/first_level/first_level_page.dart';
import 'package:hackday/pages/login/login_presenter.dart';

class GetXLoginPresenter extends GetxController implements ILoginPresenter {
  final RxBool _loading = false.obs;
  @override
  bool get loading => _loading.value;
  @override
  set loading(bool value) => _loading.value = value;

  final Rx<UserCredential?> _user = Rx(null);
  @override
  UserCredential? get user => _user.value;
  @override
  set user(UserCredential? value) => _user.value = value;

  @override
  Future<Map<String, dynamic>?> verifyUserProfile() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(
          userId,
        )
        .get();

    return userDoc.data();
  }

  Future<void> saveTokenToDatabase() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    if (userId.isNotEmpty) {
      final token = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'notificationId': FieldValue.arrayUnion([token]),
      });
    }
  }

  Future<void> updateSocialUser(GoogleSignInAccount? googleSign) async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(userId).set(
      {
        'email': googleSign?.email,
        'name': googleSign?.displayName,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'lastUpdate': FieldValue.serverTimestamp(),
        'isAdmin': false,
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        _loading.value = true;
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential;
        await updateSocialUser(googleSignInAccount);
        () => Get.offAllNamed(FirstLevelPage.route);
      } on FirebaseAuthException catch (e) {
        e.message;
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        e;
      } finally {
        _loading.value = false;
      }
    }

    return user;
  }
}
