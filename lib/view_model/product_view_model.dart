import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class ProductViewModel implements Equatable {
  ProductViewModel({
    required this.img,
    required this.name,
    required this.price,
    required this.count,
  });

  final String img;
  final String name;
  final String price;
  RxInt count;

  factory ProductViewModel.fromMap(Map<String, dynamic> map) {
    return ProductViewModel(
      img: map['img'],
      name: map['name'],
      price: map['price'],
      count: map['count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'img': img, 'name': name, 'price': price, 'count': count};
  }

  @override
  List<Object?> get props => [img, name, price, count];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return "name: $name price: $price";
  }
}
