import 'package:flutter/material.dart';

class MeSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const MeSubmitButton({
    super.key,
    required this.onPressed,
    this.label = "Submit",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
