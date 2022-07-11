import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {Key? key,
      this.icon,
      required this.hintText,
      this.keyboardType,
      this.obscureText,
      required this.controller})
      : super(key: key);

  final IconData? icon;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 15,
          ),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Colors.grey,
                )
              : null,
          hintText: hintText,
        ),
      ),
    );
  }
}
