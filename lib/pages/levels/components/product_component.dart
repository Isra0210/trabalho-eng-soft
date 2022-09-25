import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/view_model/product_view_model.dart';

import '../levels_presenter.dart';

class ProductComponent extends StatefulWidget {
  const ProductComponent({
    required this.product,
    Key? key,
  }) : super(key: key);

  final ProductViewModel product;

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    final ILevelsPresenter presenter = Get.find<ILevelsPresenter>();
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.product.img,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                widget.product.name,
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                'R\$ ${widget.product.price}',
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ],
          ),
          Obx(() {
            final productIndex =
                presenter.productsSelected.indexOf(widget.product);
            return presenter.productsSelected.contains(widget.product)
                ? Visibility(
                  visible: presenter.productsSelected[productIndex].count.value > 0,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 86),
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              presenter.productsSelected[productIndex].count;
                              return Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      presenter
                                        .productsSelected[productIndex].count--;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }),
                            Obx(() {
                              return Text(
                                presenter.productsSelected[productIndex].count
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  backgroundColor: Colors.white,
                                ),
                              );
                            }),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: Obx(() {
                                presenter.productsSelected[productIndex].count;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      presenter
                                          .productsSelected[productIndex].count++;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
