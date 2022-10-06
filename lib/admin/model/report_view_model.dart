import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class ReportViewModel implements Equatable {
  ReportViewModel({
    required this.cashChange,
    required this.name,
    required this.total,
    required this.totalSelected,
  });

  final String cashChange;
  final String name;
  final String total;
  final String totalSelected;

  factory ReportViewModel.fromMap(Map<String, dynamic> map) {
    return ReportViewModel(
      cashChange: map['cash_change'],
      name: map['name'],
      total: map['total'],
      totalSelected: map['total_selected'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'name': name,
      'cashChange': cashChange,
      'totalSelected,': totalSelected,
    };
  }

  @override
  List<Object?> get props => [total, name, totalSelected, cashChange];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return "name: $name total: $total cashChange: $cashChange";
  }
}
