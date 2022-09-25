import 'package:flutter/material.dart';

class BackgroundImageComponent extends StatelessWidget {
  const BackgroundImageComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://img.elo7.com.br/product/zoom/28EAA87/papel-de-parede-adesivo-cinema-papel-de-parede-filme.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
