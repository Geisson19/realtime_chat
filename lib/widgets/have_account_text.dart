import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels(
      {Key? key,
      required this.auxText,
      required this.text,
      required this.route})
      : super(key: key);

  final String auxText;
  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(auxText,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 148, 148, 148))),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Text(text,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 166, 255))),
        ),
      ],
    );
  }
}
