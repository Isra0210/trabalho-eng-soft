import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/background_image_component.dart';
import '../levels/first_level/first_level_page.dart';

class UnsuccessfullyPage extends StatelessWidget {
  const UnsuccessfullyPage({Key? key}) : super(key: key);

  static const route = '/unsuccessfully';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sinto muito!',
          style: TextStyle(
            color: Colors.blueGrey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        leading: IconButton(icon: Icon(Icons.logout, color: Colors.blueGrey.shade900), onPressed: (){}),
        centerTitle: true,
        backgroundColor: Colors.red.shade700,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const BackgroundImageComponent(),
          Center(
              child: Icon(
            Icons.cancel,
            color: Colors.red.shade700,
            size: 300,
          ))
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Get.offAllNamed(FirstLevelPage.route),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.red.shade700,
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
