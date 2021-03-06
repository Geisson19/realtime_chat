import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, required this.titulo}) : super(key: key);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 180,
      child: Column(children: [
        const Image(image: AssetImage('assets/tag-logo.png')),
        const SizedBox(height: 20),
        Text(titulo,
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 64, 64, 64)))
      ]),
    ));
  }
}
