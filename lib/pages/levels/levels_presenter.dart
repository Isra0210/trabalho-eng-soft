import 'package:hackday/admin/model/report_view_model.dart';
import 'package:hackday/view_model/banknotes_view_model.dart';
import 'package:hackday/view_model/product_view_model.dart';

abstract class ILevelsPresenter {
  List<ProductViewModel> get products;
  List<BankNotesViewModel> get banknotes;

  List<ProductViewModel> get productsSelected;
  set productsSelected(List<ProductViewModel> value);

  List<BankNotesViewModel> get bacnknotesSelected;
  set bacnknotesSelected(List<BankNotesViewModel> value);

  List<BankNotesViewModel> get cashChange;
  set cashChange(List<BankNotesViewModel> value);
  
  Stream<List<ReportViewModel>> getReports();

  Future<void> uploadFlow(
    String total,
    String totalSelected,
    String cashChange,
  );
}
