import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/view_model/product_view_model.dart';

import '../levels_presenter.dart';

class ProductComponent extends StatefulWidget {
  const ProductComponent({
    required this.product,
    required this.canEditCount,
    required this.presenter,
    Key? key,
  }) : super(key: key);

  final ProductViewModel product;
  final bool canEditCount;
  final ILevelsPresenter presenter;

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(-1, -1),
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 1,
          ),
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: AssetImage(widget.product.img),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              widget.canEditCount
                  ? Obx(() {
                      final productIndex = widget.presenter.productsSelected
                          .indexOf(widget.product);
                      return widget.presenter.productsSelected
                              .contains(widget.product)
                          ? Visibility(
                              visible: widget
                                      .presenter
                                      .productsSelected[productIndex]
                                      .count
                                      .value >
                                  0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                  vertical: 6,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      widget.presenter
                                          .productsSelected[productIndex].count;
                                      return Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget
                                                  .presenter
                                                  .productsSelected[
                                                      productIndex]
                                                  .count--;
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
                                        widget
                                            .presenter
                                            .productsSelected[productIndex]
                                            .count
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
                                        widget
                                            .presenter
                                            .productsSelected[productIndex]
                                            .count;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget
                                                  .presenter
                                                  .productsSelected[
                                                      productIndex]
                                                  .count++;
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
                            )
                          : const SizedBox();
                    })
                  : const SizedBox(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              widget.product.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'R\$ ${widget.product.price}',
              style: const TextStyle(fontSize: 22, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
