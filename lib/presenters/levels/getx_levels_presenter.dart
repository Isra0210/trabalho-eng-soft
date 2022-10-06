import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hackday/admin/model/report_view_model.dart';
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

  final RxList<BankNotesViewModel> _bancknotesSelected =
      RxList<BankNotesViewModel>([]);
  @override
  List<BankNotesViewModel> get bancknotesSelected => _bancknotesSelected;
  @override
  set bancknotesSelected(List<BankNotesViewModel> value) =>
      _bancknotesSelected.value = value;

  final RxList<BankNotesViewModel> _cashChange = RxList<BankNotesViewModel>([]);
  @override
  List<BankNotesViewModel> get cashChange => _cashChange;
  @override
  set cashChange(List<BankNotesViewModel> value) => _cashChange.value = value;

  @override
  Future<void> uploadFlow(
    String total,
    String totalSelected,
    String cashChange,
  ) async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection('reports');

    final String docId = ref.doc().id;

    ref.doc(docId).set({
      "total": total,
      "total_selected": totalSelected,
      "cash_change": cashChange,
      "name": FirebaseAuth.instance.currentUser!.displayName,
    }, SetOptions(merge: true));
  }

  @override
  Stream<List<ReportViewModel>> getReports() {
    final ref = FirebaseFirestore.instance
        .collection('reports')
        .withConverter<ReportViewModel>(
          fromFirestore: (snapshot, _) =>
              ReportViewModel.fromMap(snapshot.data()!),
          toFirestore: (report, _) => report.toMap(),
        )
        .snapshots();
    final result = ref.map<List<ReportViewModel>>((qShot) {
      return qShot.docs.map((doc) => doc.data()).toList();
    });
    return result;
  }
}
