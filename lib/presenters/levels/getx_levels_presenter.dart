import 'package:get/get.dart';
import 'package:hackday/pages/data/data.dart';
import 'package:hackday/view_model/banknotes_view_model.dart';
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

  final RxList<BankNotesViewModel> _banknotes = RxList<BankNotesViewModel>([
    ...(Data.banknotes as List<Map<String, dynamic>>).map(
      (notes) => BankNotesViewModel.fromMap(notes),
    )
  ]);
  @override
  List<BankNotesViewModel> get banknotes => _banknotes;

  final RxList<ProductViewModel> _productsSelected =
      RxList<ProductViewModel>([]);
  @override
  List<ProductViewModel> get productsSelected => _productsSelected;
  @override
  set productsSelected(List<ProductViewModel> value) =>
      _productsSelected.value = value;

  final RxList<BankNotesViewModel> _bacnknotesSelected =
      RxList<BankNotesViewModel>([]);
  @override
  List<BankNotesViewModel> get bacnknotesSelected => _bacnknotesSelected;
  @override
  set bacnknotesSelected(List<BankNotesViewModel> value) =>
      _bacnknotesSelected.value = value;
}
