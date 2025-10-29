import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/share_service.dart';

class AchievementDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const AchievementDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                description.isNotEmpty
                    ? description
                    : AppLocalizations.of(context)!.emptyDescription,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await ShareService.shareAchievement(
                      context: context,
                      icon: icon,
                      title: title,
                      description: description,
                      color: color,
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: Text(AppLocalizations.of(context)!.shareTitle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
