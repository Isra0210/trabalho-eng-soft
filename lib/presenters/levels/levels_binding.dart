import 'package:get/get.dart';
import 'package:hackday/pages/login/login_presenter.dart';
import 'package:hackday/presenters/login/getx_login_presenter.dart';

import '../../pages/levels/levels_presenter.dart';
import 'getx_levels_presenter.dart';

class LevelsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ILoginPresenter>(GetXLoginPresenter());
    Get.put<ILevelsPresenter>(GetXLevelsPresenter());
  }
}