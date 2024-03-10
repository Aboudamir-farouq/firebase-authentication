import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.isPassword = false,
    required this.hintText,
    required this.suffixIcon,
    required this.inputController
  });

  final bool isPassword;
  final String hintText;
  final IconData suffixIcon;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: inputController,
        obscureText: isPassword,
        decoration: InputDecoration(
          suffixIcon: Icon(suffixIcon, color: Colors.grey[500]),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          )
        ),
      ),
    );
  }
}