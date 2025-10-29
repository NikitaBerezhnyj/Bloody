import 'package:flutter/material.dart';

class AchievementTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool achieved;
  final String description;

  const AchievementTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.achieved,
    this.description = "",
  });

  @override
  Widget build(BuildContext context) {
    final color = achieved ? Colors.red : Colors.grey;

    return GestureDetector(
      onTap: () {
        if (!achieved) return;

        showDialog(
          context: context,
          builder: (_) => Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          size: 60,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description.isNotEmpty ? description : "No description",
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          print("Share $title");
                        },
                        icon: const Icon(Icons.share),
                        label: const Text("Share"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: subtitle.isNotEmpty
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 40, color: color),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
                  : Icon(icon, size: 40, color: color),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
