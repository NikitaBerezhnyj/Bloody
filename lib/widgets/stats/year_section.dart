import 'package:bloody/widgets/stats/year_nav_button.dart';
import 'package:bloody/widgets/stats/year_type_breakdown.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';

class YearSection extends StatelessWidget {
  final int selectedYear;
  final List<int> availableYears;
  final DonationStats yearStats;
  final AppLocalizations t;
  final ValueChanged<int> onYearChanged;

  const YearSection({
    required this.selectedYear,
    required this.availableYears,
    required this.yearStats,
    required this.t,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    final idx     = availableYears.indexOf(selectedYear);
    final canPrev = idx > 0;
    final canNext = idx < availableYears.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              t.statsPerYear,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            YearNavButton(
              icon: Icons.chevron_left,
              enabled: canPrev,
              onTap: canPrev ? () => onYearChanged(availableYears[idx - 1]) : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '$selectedYear',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            YearNavButton(
              icon: Icons.chevron_right,
              enabled: canNext,
              onTap: canNext ? () => onYearChanged(availableYears[idx + 1]) : null,
            ),
          ],
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.shade100, width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${yearStats.total}',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    t.statsDonationsYear,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (yearStats.total > 0)
                YearTypeBreakdown(stats: yearStats, t: t),
            ],
          ),
        ),
      ],
    );
  }
}