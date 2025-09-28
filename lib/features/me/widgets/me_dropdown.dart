import 'package:flutter/material.dart';

class MeDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const MeDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  InputDecoration _decoration() {
    return InputDecoration(
      labelText: "Gender",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: _decoration(),
      items: items.map((g) {
        return DropdownMenuItem(value: g, child: Text(g));
      }).toList(),
      onChanged: onChanged,
    );
  }
}
