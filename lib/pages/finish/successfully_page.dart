import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackday/pages/levels/first_level/first_level_page.dart';

import '../components/background_image_component.dart';

class SuccessfullyPage extends StatelessWidget {
  const SuccessfullyPage({Key? key}) : super(key: key);

  static const route = '/successfully';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parabéns',
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
        backgroundColor: Colors.green.shade600,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const BackgroundImageComponent(),
          Center(
              child: Icon(
            Icons.check_circle,
            color: Colors.green.shade600,
            size: 300,
          ))
        ],
      ),
      bottomNavigationBar: GestureDetector(
        //TODO fazer integração
        onTap: () => Get.offAllNamed(FirstLevelPage.route),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.green.shade600,
          height: 40,
          child: const Text(
            'Reiniciar',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
