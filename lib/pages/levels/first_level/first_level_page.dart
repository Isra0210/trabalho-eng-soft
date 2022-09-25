import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/components/background_image_component.dart';
import 'package:hackday/pages/levels/components/product_component.dart';
import 'package:hackday/pages/levels/levels_presenter.dart';

class FirstLevelPage extends StatefulWidget {
  const FirstLevelPage({Key? key}) : super(key: key);

  static const route = '/first-level';

  @override
  State<FirstLevelPage> createState() => _FirstLevelPageState();
}

class _FirstLevelPageState extends State<FirstLevelPage> {
  @override
  Widget build(BuildContext context) {
    final ILevelsPresenter presenter = Get.find<ILevelsPresenter>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Fase 1',
          style: TextStyle(
            color: Colors.blueGrey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            backgroundColor: Colors.white60,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white24,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Text(
            'Selecione seus produtos',
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 26,
              backgroundColor: Colors.white60,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const BackgroundImageComponent(),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                ...presenter.products.map(
                  (product) => GestureDetector(
                    onTap: () {
                      final index = presenter.productsSelected.indexOf(product);
                      if (presenter.productsSelected.contains(product)) {
                        presenter.productsSelected[index].count = 1.obs;
                        presenter.productsSelected.remove(product);
                      } else {
                        presenter.productsSelected.add(product);
                      }
                    },
                    child: ProductComponent(product: product),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Valor total: ",
              style: TextStyle(fontSize: 18),
            ),
            Obx(() {
              double total = 0;
              //ignore: avoid_function_literals_in_foreach_calls
              presenter.productsSelected.forEach((product) {
                total =
                    total + (double.parse(product.price) * product.count.value);
              });
              return Text(
                "R\$ $total",
                style: const TextStyle(fontSize: 18),
              );
            })
          ],
        ),
      ),
    );
  }
}
