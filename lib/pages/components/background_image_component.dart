import 'package:flutter/material.dart';

class BackgroundImageComponent extends StatelessWidget {
  const BackgroundImageComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
