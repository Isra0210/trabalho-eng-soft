import 'package:hackday/view_model/product_view_model.dart';

abstract class ILevelsPresenter {
  List<ProductViewModel> get products;
  
  List<ProductViewModel> get productsSelected;
  set productsSelected(List<ProductViewModel> value);  
}

