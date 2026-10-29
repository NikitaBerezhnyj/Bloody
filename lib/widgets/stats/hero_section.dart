import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';

class HeroSection extends StatelessWidget {
  final DonationStats stats;
  final AppLocalizations t;

  const HeroSection({super.key, required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.primaryContainer,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${stats.total}',
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.statsTotalDonations,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '≈${stats.total * 3} ${t.statsLivesLabel}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.opacity,
              size: 72,
              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
