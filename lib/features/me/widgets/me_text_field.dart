import 'package:flutter/material.dart';

class MeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType keyboardType;

  const MeTextField({
    super.key,
    required this.controller,
    required this.label,
    this.readOnly = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
  });

  InputDecoration _decoration() {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      decoration: _decoration(),
    );
  }
}
