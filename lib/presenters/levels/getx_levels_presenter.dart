import 'package:get/get.dart';
import 'package:hackday/pages/data/product_data.dart';
import 'package:hackday/view_model/product_view_model.dart';

import '../../pages/levels/levels_presenter.dart';

class GetXLevelsPresenter extends GetxController implements ILevelsPresenter {
  final RxList<ProductViewModel> _products = RxList<ProductViewModel>([
    ...(Data.products as List<Map<String, dynamic>>).map(
      (product) => ProductViewModel.fromMap(product),
    )
  ]);
  @override
  List<ProductViewModel> get products => _products;

  final RxList<ProductViewModel> _productsSelected =
      RxList<ProductViewModel>([]);
  @override
  List<ProductViewModel> get productsSelected => _productsSelected;
  @override
  set productsSelected(List<ProductViewModel> value) =>
      _productsSelected.value = value;
}
