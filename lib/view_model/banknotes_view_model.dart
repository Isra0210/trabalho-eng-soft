import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class BankNotesViewModel implements Equatable {
  BankNotesViewModel({
    required this.img,
    required this.value,
    required this.count,
  });

  final String img;
  final String value;
  RxInt count;

  factory BankNotesViewModel.fromMap(Map<String, dynamic> map) {
    return BankNotesViewModel(
      img: map['img'],
      value: map['value'],
      count: map['count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'img': img, 'value': value, 'count': count};
  }

  @override
  List<Object?> get props => [img, value, count];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return "value: $value";
  }
}
