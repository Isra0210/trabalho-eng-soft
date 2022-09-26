import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/levels/components/product_component.dart';
import 'package:hackday/pages/levels/third_level/third_level.dart';

import '../../components/background_image_component.dart';
import '../levels_presenter.dart';

class SecondLevelPage extends StatefulWidget {
  const SecondLevelPage({Key? key}) : super(key: key);

  static const route = '/second-level';

  @override
  State<SecondLevelPage> createState() => _SecondLevelPageState();
}

class _SecondLevelPageState extends State<SecondLevelPage> {
  @override
  Widget build(BuildContext context) {
    final ILevelsPresenter presenter = Get.find<ILevelsPresenter>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione as cédulas',
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
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(57, 210, 192, 1),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blueGrey.shade900,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Valor total: ",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Obx(() {
                      double total = 0;
                      //ignore: avoid_function_literals_in_foreach_calls
                      presenter.productsSelected.forEach((product) {
                        total = total +
                            (double.parse(product.price) * product.count.value);
                      });
                      return Text(
                        "R\$ $total",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      );
                    })
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Valor selecionado: ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Obx(() {
                        double total = 0;
                        //ignore: avoid_function_literals_in_foreach_calls
                        presenter.bacnknotesSelected.forEach(
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
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const BackgroundImageComponent(),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                width: MediaQuery.of(context).size.width,
                color: Colors.blueGrey.shade900,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...presenter.productsSelected.map(
                        (product) => SizedBox(
                          height: 200,
                          width: 200,
                          child: ProductComponent(
                            product: product,
                            canEditCount: false,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...presenter.banknotes.map(
                        (note) => GestureDetector(
                          onTap: () {
                            final index =
                                presenter.bacnknotesSelected.indexOf(note);
                            if (presenter.bacnknotesSelected.contains(note)) {
                              presenter.bacnknotesSelected[index].count = 1.obs;
                              presenter.bacnknotesSelected.remove(note);
                            } else {
                              presenter.bacnknotesSelected.add(note);
                            }
                          },
                          child: Obx(
                             () {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      !presenter.bacnknotesSelected.contains(note)
                                          ? 35.0
                                          : 0,
                                ),
                                child: Column(
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
                                          image: NetworkImage(note.img),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Obx(() {
                                      final index = presenter.bacnknotesSelected
                                          .indexOf(note);
                                      return presenter.bacnknotesSelected
                                              .contains(note)
                                          ? Visibility(
                                              visible: presenter
                                                      .bacnknotesSelected[index]
                                                      .count
                                                      .value >
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Obx(() {
                                                      presenter
                                                          .bacnknotesSelected[index]
                                                          .count;
                                                      return Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.red,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              presenter
                                                                  .bacnknotesSelected[
                                                                      index]
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
                                                        presenter
                                                            .bacnknotesSelected[
                                                                index]
                                                            .count
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      );
                                                    }),
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.green,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Obx(() {
                                                        presenter
                                                            .bacnknotesSelected[
                                                                index]
                                                            .count;
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              presenter
                                                                  .bacnknotesSelected[
                                                                      index]
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
                                  ],
                                ),
                              );
                            }
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: Obx(() {
        return Visibility(
          visible: presenter.bacnknotesSelected.isNotEmpty,
          child: GestureDetector(
            onTap: () => Get.toNamed(ThirdLevelPage.route),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              color: const Color.fromRGBO(57, 210, 192, 1),
              height: 40,
              child: const Text(
                'Próximo nível',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
      }),
    );
  }
}
