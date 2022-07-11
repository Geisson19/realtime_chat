import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Términos y condiciones de uso',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
    );
  }
}
