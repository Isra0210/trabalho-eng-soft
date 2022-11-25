import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/levels/first_level/first_level_page.dart';
import 'package:hackday/pages/levels/levels_presenter.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  static const route = '/feedback';

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final ILevelsPresenter presenter = Get.arguments;
  List<String> resultsOnPayments = [];
  List<String> resultsOnCashChange = [];

  void compileResult() {
    if (double.parse(Get.parameters["totalSelected"]!) <
        double.parse(Get.parameters["total"]!)) {
      resultsOnPayments
          .add("Seu valor de pagamento está abaixo do valor total!");
    } else if (double.parse(Get.parameters["totalSelected"]!) ==
        double.parse(Get.parameters["total"]!)) {
      resultsOnPayments.add("Você efetuou o pagamento corretamente!");
    } else {
      resultsOnPayments.add("Você efetuou o pagamento a mais do valor total!");
    }
    if (double.parse(Get.parameters["cashChange"]!) <
        (double.parse(Get.parameters["total"]!) -
            double.parse(Get.parameters["totalSelected"]!))) {
      resultsOnCashChange.add(
          "Você selecionou o troco a baixo do valor que você deveria receber!");
    } else if (double.parse(Get.parameters["cashChange"]!) ==
        (double.parse(Get.parameters["total"]!) -
            double.parse(Get.parameters["totalSelected"]!))) {
      resultsOnCashChange.add("Você selecionou o troco corretamente!");
    } else {
      resultsOnCashChange
          .add("Você selecionou troco a mais do que deveria receber!");
    }
  }

  @override
  void initState() {
    compileResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FEEDBACK',
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
            icon: Icon(
              Icons.logout,
              color: Colors.blueGrey.shade900,
            ),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
        centerTitle: true,
        backgroundColor: Get.parameters["success"]!.contains("true")
            ? Colors.green
            : Colors.red,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blueGrey.shade900,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "PRODUTOS",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ...presenter.productsSelected.map(
              (product) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 1),
                    ),
                    BoxShadow(
                      offset: Offset(-1, -1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      minRadius: 30,
                      backgroundImage: AssetImage(product.img),
                    ),
                    Text(
                      product.name,
                      style: const TextStyle(fontSize: 22),
                    ),
                    Text(
                      "${product.count}x",
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey.shade900,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "VALORES",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "TOTAL",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "R\$ ${Get.parameters["total"]}",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      )
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
                        "PAGAMENTO",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        "R\$ ${Get.parameters["totalSelected"]}",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
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
                        "TROCO",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),

                      Text(
                        "R\$ ${Get.parameters["cashChange"]}",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.blueGrey.shade900,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "RESULTADO",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PAGAMENTO: ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ...resultsOnPayments.map(
                    (resOnPay) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        resOnPay.toUpperCase(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey.shade900,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TROCO: ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ...resultsOnCashChange.map(
                    (resOnCash) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        resOnCash.toUpperCase(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey.shade900,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          double total = 0;
          //ignore: avoid_function_literals_in_foreach_calls
          presenter.productsSelected.forEach((product) {
            total = total + (double.parse(product.price) * product.count.value);
          });

          double totalSelected = 0;
          //ignore: avoid_function_literals_in_foreach_calls
          presenter.bancknotesSelected.forEach(
            (product) {
              totalSelected = totalSelected +
                  (double.parse(product.value) * product.count.value);
            },
          );

          double cashChange = 0;
          //ignore: avoid_function_literals_in_foreach_calls
          presenter.cashChange.forEach(
            (product) {
              cashChange = cashChange +
                  (double.parse(product.value) * product.count.value);
            },
          );

          await presenter.uploadFlow(
            total.toString(),
            totalSelected.toString(),
            cashChange.toString(),
          );
          Get.offAllNamed(FirstLevelPage.route);
        },
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          color: Get.parameters["success"]!.contains("true")
              ? Colors.green
              : Colors.red,
          height: 40,
          child: const Text(
            'REINICIAR',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
