import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';
import '../../utils/donation_labels.dart';
import '../donation/detail_card.dart';

class SummarySection extends StatelessWidget {
  final DonationStats stats;
  final AppLocalizations t;

  const SummarySection({super.key, required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final types = [
      ('donationWholeBlood', stats.wholeBlood),
      ('donationPlasma', stats.plasma),
      ('donationPlatelets', stats.platelets),
    ].where((e) => e.$2 > 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${stats.total}',
          style: theme.textTheme.displayMedium?.copyWith(
            color: scheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(t.statsTotalDonations, style: theme.textTheme.titleMedium),
        const SizedBox(height: 20),
        DetailCard(
          children: [
            for (final (key, count) in types)
              _TypeRow(
                icon: typeIcon(key),
                label: typeLabel(t, key),
                count: count,
                share: count / stats.total,
              ),
          ],
        ),
      ],
    );
  }
}

class _TypeRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final double share;

  const _TypeRow({
    required this.icon,
    required this.label,
    required this.count,
    required this.share,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: scheme.primary, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(value: share, minHeight: 6),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 36,
            child: Text(
              '$count',
              textAlign: TextAlign.end,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
