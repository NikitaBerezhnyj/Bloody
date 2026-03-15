import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';
import '../common/detail_row.dart';

class DetailsSection extends StatelessWidget {
  final DonationStats stats;
  final AppLocalizations t;

  const DetailsSection({required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.statsDetails,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              DetailRow(
                icon: Icons.history,
                label: t.statsLastDonation,
                value: stats.lastDonationDate,
                trailing: _daysAgoText(stats.daysSinceLast, t),
              ),
              if (stats.avgIntervalDays > 0) ...[
                Divider(
                  height: 1,
                  indent: 52,
                  color: Colors.grey.shade200,
                ),
                DetailRow(
                  icon: Icons.timer_outlined,
                  label: t.statsAvgInterval,
                  value: '${stats.avgIntervalDays} ${t.statsDays}',
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _daysAgoText(int days, AppLocalizations t) {
    if (days == 0) return t.statsToday;
    if (days == 1) return t.statsYesterday;
    final n  = days % 100;
    final n1 = days % 10;
    if (n >= 11 && n <= 19) return t.statsDaysAgoMany(days);
    if (n1 == 1)            return t.statsDaysAgo1(days);
    if (n1 >= 2 && n1 <= 4) return t.statsDaysAgo2(days);
    return t.statsDaysAgoMany(days);
  }
}