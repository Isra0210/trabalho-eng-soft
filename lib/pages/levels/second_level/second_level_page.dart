import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/components/background_image_component.dart';
import 'package:hackday/pages/levels/components/product_component.dart';
import 'package:hackday/pages/levels/levels_presenter.dart';
import 'package:hackday/pages/levels/third_level/third_level.dart';

class SecondLevelPage extends StatefulWidget {
  const SecondLevelPage({
    required this.levelsPresenter,
    Key? key,
  }) : super(key: key);

  static const route = '/second-level';

  final ILevelsPresenter levelsPresenter;

  @override
  State<SecondLevelPage> createState() => _SecondLevelPageState();
}

class _SecondLevelPageState extends State<SecondLevelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pagamento',
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
              onPressed: () {}),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(57, 210, 192, 1),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
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
                        "Valor total: ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Obx(() {
                        double total = 0;
                        widget.levelsPresenter.productsSelected
                            //ignore: avoid_function_literals_in_foreach_calls
                            .forEach((product) {
                          total = total +
                              (double.parse(product.price) *
                                  product.count.value);
                        });
                        return Text(
                          "R\$ $total",
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
                        "Valor selecionado: ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Obx(() {
                        double total = 0;
                        //ignore: avoid_function_literals_in_foreach_calls
                        widget.levelsPresenter.bacnknotesSelected.forEach(
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
                        ...widget.levelsPresenter.productsSelected.map(
                          (product) => Container(
                            height: 200,
                            width: 160,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: ProductComponent(
                              presenter: widget.levelsPresenter,
                              product: product,
                              canEditCount: false,
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
            child: CarouselSlider(
              options: CarouselOptions(
                height: 280.0,
                aspectRatio: 16 / 9,
                disableCenter: false,
                viewportFraction: 1,
              ),
              items: [
                ...widget.levelsPresenter.banknotes.map(
                  (note) => GestureDetector(
                    onTap: () {
                      final index = widget.levelsPresenter.bacnknotesSelected
                          .indexOf(note);
                      if (widget.levelsPresenter.bacnknotesSelected
                          .contains(note)) {
                        widget.levelsPresenter.bacnknotesSelected[index]
                            .count = 1.obs;
                        widget.levelsPresenter.bacnknotesSelected
                            .remove(note);
                      } else {
                        widget.levelsPresenter.bacnknotesSelected.add(note);
                      }
                    },
                    child: Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: !widget.levelsPresenter.bacnknotesSelected
                                  .contains(note)
                              ? 35.0
                              : 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              height: 170,
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
                              final index = widget
                                  .levelsPresenter.bacnknotesSelected
                                  .indexOf(note);
                              return widget.levelsPresenter.bacnknotesSelected
                                      .contains(note)
                                  ? Visibility(
                                      visible: widget
                                              .levelsPresenter
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() {
                                              widget
                                                  .levelsPresenter
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
                                                      widget
                                                          .levelsPresenter
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
                                                widget
                                                    .levelsPresenter
                                                    .bacnknotesSelected[index]
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
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Obx(() {
                                                widget
                                                    .levelsPresenter
                                                    .bacnknotesSelected[index]
                                                    .count;
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      widget
                                                          .levelsPresenter
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
                    }),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return Visibility(
          visible: widget.levelsPresenter.bacnknotesSelected.isNotEmpty,
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
