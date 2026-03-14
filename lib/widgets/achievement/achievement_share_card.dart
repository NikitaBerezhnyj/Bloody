import 'package:flutter/material.dart';

class AchievementShareCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const AchievementShareCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 800,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: color.withOpacity(0.1),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bloody",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 70, color: color),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
