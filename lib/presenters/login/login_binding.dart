import 'package:get/get.dart';
import 'package:hackday/pages/login/login_presenter.dart';
import 'package:hackday/presenters/login/getx_login_presenter.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ILoginPresenter>(GetXLoginPresenter());
  }
}