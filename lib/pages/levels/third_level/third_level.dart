import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/finish/feedback_page.dart';
import 'package:hackday/pages/levels/components/product_component.dart';

import '../../components/background_image_component.dart';
import '../levels_presenter.dart';

class ThirdLevelPage extends StatefulWidget {
  const ThirdLevelPage({required this.presenter, Key? key}) : super(key: key);

  static const route = '/third-level';
  final ILevelsPresenter presenter;

  @override
  State<ThirdLevelPage> createState() => _ThirdLevelPageState();
}

class _ThirdLevelPageState extends State<ThirdLevelPage> {
  late CarouselController controller;

  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Troco',
          style: TextStyle(
            color: Colors.blueGrey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.blueGrey.shade900,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.blueGrey.shade900),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(57, 210, 192, 1),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 90),
          child: Container(
            color: Colors.blueGrey.shade900,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "TOTAL:",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Obx(() {
                        double amoutValueAllProductSelected = 0;
                        //ignore: avoid_function_literals_in_foreach_calls
                        widget.presenter.productsSelected.forEach((product) {
                          amoutValueAllProductSelected = amoutValueAllProductSelected +
                              (double.parse(product.price) *
                                  product.count.value);
                        });
                        return Text(
                          "R\$ $amoutValueAllProductSelected",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        );
                      })
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "PAGAMENTO:",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Obx(() {
                        double total = 0;
                        //ignore: avoid_function_literals_in_foreach_calls
                        widget.presenter.bancknotesSelected.forEach(
                          (product) {
                            total = total +
                                (double.parse(product.value) *
                                    product.count.value);
                          },
                        );
                        return Text(
                          "R\$ $total",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        );
                      })
                      //
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  color: Colors.cyan,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "TROCO: ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Obx(() {
                        double totalCashChanges = 0;
                        //ignore: avoid_function_literals_in_foreach_calls
                        widget.presenter.cashChange.forEach(
                          (product) {
                            totalCashChanges = totalCashChanges +
                                (double.parse(product.value) *
                                    product.count.value);
                          },
                        );
                        return Text(
                          "R\$ $totalCashChanges",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        );
                      })
                      //
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                const BackgroundImageComponent(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 6,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...widget.presenter.productsSelected.map(
                          (product) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 200,
                            width: 160,
                            child: ProductComponent(
                              product: product,
                              canEditCount: false,
                              presenter: widget.presenter,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return CarouselSlider(
                key: const Key("carouselThirdLevelPageKey"),
                carouselController: controller,
                options: CarouselOptions(
                  height: 280.0,
                  aspectRatio: 16 / 9,
                  disableCenter: false,
                  viewportFraction: 1,
                ),
                items: [
                  ...widget.presenter.banknotes.map(
                    (note) => GestureDetector(
                      onTap: () {
                        final index = widget.presenter.cashChange.indexOf(note);
                        if (widget.presenter.cashChange.contains(note)) {
                          widget.presenter.cashChange[index].count = 1.obs;
                          widget.presenter.cashChange.remove(note);
                        } else {
                          widget.presenter.cashChange.add(note);
                        }
                      },
                      child: Obx(() {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: !widget.presenter.cashChange.contains(note)
                                ? 35.0
                                : 0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                height: 160,
                                width: 300,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(note.img),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Obx(() {
                                final index =
                                    widget.presenter.cashChange.indexOf(note);
                                return widget.presenter.cashChange
                                        .contains(note)
                                    ? Visibility(
                                        visible: widget.presenter
                                                .cashChange[index].count.value >
                                            0,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          width: 300,
                                          color: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0,
                                            vertical: 6,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Obx(() {
                                                widget.presenter
                                                    .cashChange[index].count;
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        widget
                                                            .presenter
                                                            .cashChange[index]
                                                            .count--;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: 26,
                                                    ),
                                                  ),
                                                );
                                              }),
                                              Obx(() {
                                                return Text(
                                                  widget.presenter
                                                      .cashChange[index].count
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                );
                                              }),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: const BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Obx(() {
                                                  widget.presenter
                                                      .cashChange[index].count;
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        widget
                                                            .presenter
                                                            .cashChange[index]
                                                            .count++;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 26,
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
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                ],
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        double total = 0;
        //ignore: avoid_function_literals_in_foreach_calls
        widget.presenter.productsSelected.forEach((product) {
          total = total + (double.parse(product.price) * product.count.value);
        });

        double totalSelected = 0;
        //ignore: avoid_function_literals_in_foreach_calls
        widget.presenter.bancknotesSelected.forEach(
          (product) {
            totalSelected = totalSelected +
                (double.parse(product.value) * product.count.value);
          },
        );

        double cashChange = 0;
        //ignore: avoid_function_literals_in_foreach_calls
        widget.presenter.cashChange.forEach(
          (product) {
            cashChange = cashChange +
                (double.parse(product.value) * product.count.value);
          },
        );

        final bool isSuccessfully =
            total == totalSelected && total == (totalSelected + cashChange);

        return GestureDetector(
          onTap: () => Get.toNamed(
            FeedbackPage.route,
            arguments: widget.presenter,
            parameters: {
              "success": "$isSuccessfully",
              "total": "$total",
              "totalSelected": "$totalSelected",
              "cashChange": "$cashChange",
            },
          ),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            color: const Color.fromRGBO(57, 210, 192, 1),
            height: 40,
            child: const Text(
              'Finalizar',
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }),
    );
  }
}
