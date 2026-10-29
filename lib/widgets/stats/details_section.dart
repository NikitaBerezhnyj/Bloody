import 'package:bloody/widgets/common/section_label.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';
import '../common/detail_row.dart';
import '../donation/detail_card.dart';

class DetailsSection extends StatelessWidget {
  final DonationStats stats;
  final AppLocalizations t;

  const DetailsSection({super.key, required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String label, String value})>[
      if (stats.firstDate != null)
        (
          icon: Icons.calendar_today_outlined,
          label: t.statsFirstDonation,
          value: _fmt(stats.firstDate!, t),
        ),
      if (stats.lastDate != null)
        (
          icon: Icons.event_available_outlined,
          label: t.statsLastDonation,
          value: _fmt(stats.lastDate!, t),
        ),
      if (stats.avgIntervalDays != null)
        (
          icon: Icons.timelapse_outlined,
          label: t.statsAvgInterval,
          value: '${stats.avgIntervalDays} ${t.statsDays}',
        ),
      if (stats.bestYear != null)
        (
          icon: Icons.workspace_premium_outlined,
          label: t.statsBestYear,
          value: '${stats.bestYear} · ${stats.bestYearCount}×',
        ),
    ];

    if (items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label: t.statsDetails),
        const SizedBox(height: 8),
        DetailCard(
          children: [
            for (final item in items)
              DetailRow(icon: item.icon, label: item.label, value: item.value),
          ],
        ),
      ],
    );
  }

  String _fmt(DateTime d, AppLocalizations t) {
    final month = _monthName(d.month, t);
    return '${d.day} $month ${d.year}';
  }

  String _monthName(int month, AppLocalizations t) {
    switch (month) {
      case 1:
        return t.month1;
      case 2:
        return t.month2;
      case 3:
        return t.month3;
      case 4:
        return t.month4;
      case 5:
        return t.month5;
      case 6:
        return t.month6;
      case 7:
        return t.month7;
      case 8:
        return t.month8;
      case 9:
        return t.month9;
      case 10:
        return t.month10;
      case 11:
        return t.month11;
      case 12:
        return t.month12;
      default:
        return '';
    }
  }
}
