import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/levels/components/product_component.dart';
import 'package:hackday/pages/levels/levels_presenter.dart';
import 'package:hackday/pages/levels/second_level/second_level_page.dart';
import 'package:hackday/presenters/levels/getx_levels_presenter.dart';

class FirstLevelPage extends StatefulWidget {
  const FirstLevelPage({Key? key}) : super(key: key);

  static const route = '/first-level';

  @override
  State<FirstLevelPage> createState() => _FirstLevelPageState();
}

class _FirstLevelPageState extends State<FirstLevelPage> {
  @override
  Widget build(BuildContext context) {
    final ILevelsPresenter presenter =
        Get.put<ILevelsPresenter>(GetXLevelsPresenter());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produtos',
          style: TextStyle(
            color: Colors.blueGrey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.blueGrey.shade900),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(57, 210, 192, 1),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blueGrey.shade900,
            child: Row(
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
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  );
                })
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: GridView.count(
        padding: const EdgeInsets.symmetric(vertical: 20),
        crossAxisCount: 2,
        childAspectRatio: 0.9,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 230,
                  child: ProductComponent(
                    product: product,
                    canEditCount: true,
                    presenter: presenter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return Visibility(
          visible: presenter.productsSelected.isNotEmpty,
          child: GestureDetector(
            onTap: () => Get.toNamed(SecondLevelPage.route),
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
