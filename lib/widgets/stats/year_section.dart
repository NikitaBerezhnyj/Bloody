import 'package:bloody/widgets/stats/section_label.dart';
import 'package:bloody/widgets/stats/type_breakdown.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';
import 'year_nav_button.dart';

class YearSection extends StatelessWidget {
  final int selectedYear;
  final List<int> availableYears;
  final DonationStats yearStats;
  final AppLocalizations t;
  final ValueChanged<int> onYearChanged;

  const YearSection({
    super.key,
    required this.selectedYear,
    required this.availableYears,
    required this.yearStats,
    required this.t,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    final idx = availableYears.indexOf(selectedYear);
    final canPrev = idx > 0;
    final canNext = idx < availableYears.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label: t.statsPerYear),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: Colors.red.withOpacity(0.2), width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    t.statsDonationsYear,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
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
                    child: SizedBox(
                      width: 44,
                      child: Text(
                        '$selectedYear',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${yearStats.total}',
                        style: const TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          height: 1,
                          color: Colors.red,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        t.statsDonationsYear,
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  if (yearStats.total > 0) ...[
                    const SizedBox(width: 20),
                    Expanded(child: TypeBreakdown(stats: yearStats, t: t)),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}