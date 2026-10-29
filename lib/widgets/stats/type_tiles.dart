import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';
import '../../utils/donation_labels.dart';

class TypeTiles extends StatelessWidget {
  final DonationStats stats;
  final AppLocalizations t;

  const TypeTiles({super.key, required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('donationWholeBlood', stats.wholeBlood),
      ('donationPlasma', stats.plasma),
      ('donationPlatelets', stats.platelets),
    ];

    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(
            child: _TypeTile(
              icon: typeIcon(items[i].$1),
              label: typeLabel(t, items[i].$1),
              count: items[i].$2,
            ),
          ),
        ],
      ],
    );
  }
}

class _TypeTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;

  const _TypeTile({
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final active = count > 0;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: active
                    ? colorScheme.primaryContainer
                    : colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 22,
                color: active
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '$count',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: active
                    ? colorScheme.onSurface
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
