import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MediaButton extends StatelessWidget {
  final String buttonText;
  final Color bgColor;
  final Icon buttonIcon;

  const MediaButton({
    super.key,
    required this.buttonText,
    required this.bgColor,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: bgColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: bgColor == Colors.white ? Colors.grey : Colors.white,
          ),
        ),
      ),
      onPressed: () => context.go('/login'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttonIcon,
          const SizedBox(width: 12),
          Text(
            buttonText,
            style: TextStyle(
              color: bgColor == Colors.white ? Colors.black : Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
