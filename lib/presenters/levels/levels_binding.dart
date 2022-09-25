import 'package:get/get.dart';

import '../../pages/levels/levels_presenter.dart';
import 'getx_levels_presenter.dart';

class LevelsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ILevelsPresenter>(GetXLevelsPresenter());
  }
}