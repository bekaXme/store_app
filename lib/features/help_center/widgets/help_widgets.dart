import 'package:flutter/material.dart';

class HelpCenterButton extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Widget? customIcon;

  const HelpCenterButton({
    super.key,
    this.icon,
    required this.title,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        margin: EdgeInsetsGeometry.only(right: 20, left: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFFE6E6E6)
          )
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            customIcon ?? Icon(icon, size: 28),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
