import 'package:flutter/material.dart';
class RegisterField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool? isValid;
  final bool obscureText;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const RegisterField({
    super.key,
    this.onChanged,
    required this.hintText,
    this.suffixIcon,
    required this.isValid,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    if (isValid == null) {
      borderColor = Colors.grey;
    } else {
      borderColor = isValid! ? Colors.green : Colors.red;
    }

    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF808080),
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: isValid == null
            ? Colors.grey
            : (isValid! ? Colors.green : Colors.red),
      ),
    );
  }
}
