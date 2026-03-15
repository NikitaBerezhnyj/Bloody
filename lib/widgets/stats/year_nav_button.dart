import 'package:flutter/material.dart';

class YearNavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  const YearNavButton({
    required this.icon,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: enabled ? Colors.red : Colors.grey.shade300,
        size: 28,
      ),
    );
  }
}