// import 'package:flutter/material.dart';
// import '../../l10n/app_localizations.dart';
// import '../../models/donation_stats.dart';
// import '../common/detail_row.dart';
//
// class DetailsSection extends StatelessWidget {
//   final DonationStats stats;
//   final AppLocalizations t;
//
//   const DetailsSection({required this.stats, required this.t});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           t.statsDetails,
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade200),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Column(
//             children: [
//               DetailRow(
//                 icon: Icons.history,
//                 label: t.statsLastDonation,
//                 value: stats.lastDonationDate,
//                 trailing: _daysAgoText(stats.daysSinceLast, t),
//               ),
//               if (stats.avgIntervalDays > 0) ...[
//                 Divider(
//                   height: 1,
//                   indent: 52,
//                   color: Colors.grey.shade200,
//                 ),
//                 DetailRow(
//                   icon: Icons.timer_outlined,
//                   label: t.statsAvgInterval,
//                   value: '${stats.avgIntervalDays} ${t.days}',
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   String _daysAgoText(int days, AppLocalizations t) {
//     if (days == 0) return t.today;
//     if (days == 1) return t.yesterday;
//     final n  = days % 100;
//     final n1 = days % 10;
//     if (n >= 11 && n <= 19) return t.daysAgoMany(days);
//     if (n1 == 1)            return t.daysAgo1(days);
//     if (n1 >= 2 && n1 <= 4) return t.daysAgo2(days);
//     return t.daysAgoMany(days);
//   }
// }

import 'package:bloody/widgets/stats/section_label.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';

class DetailsSection extends StatelessWidget {
  final DonationStats stats;
  final AppLocalizations t;

  const DetailsSection({super.key, required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String label, String value})>[
      if (stats.firstDate != null)
        (icon: Icons.calendar_today_outlined, label: t
            .statsFirstDonation, value: _fmt(stats.firstDate!, t)),
      if (stats.lastDate != null)
        (icon: Icons.event_available_outlined, label: t
            .statsLastDonation, value: _fmt(stats.lastDate!, t)),
      if (stats.avgIntervalDays != null)
        (icon: Icons.timelapse_outlined, label: t
            .statsAvgInterval, value: '${stats.avgIntervalDays} ${t
            .statsDays}'),
      if (stats.bestYear != null)
        (icon: Icons.workspace_premium_outlined, label: t
            .statsBestYear, value: '${stats.bestYear} · ${stats
            .bestYearCount}×'),
    ];

    if (items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label: t.statsDetails),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .cardColor,
            border: Border.all(color: Colors.red.withOpacity(0.2), width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              final item = items[i];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(item.icon, color: Colors.red, size: 16),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.label,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ),
                        Text(
                          item.value,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  if (i < items.length - 1)
                    Divider(height: 1,
                        color: Colors.red.withOpacity(0.1),
                        indent: 16,
                        endIndent: 16),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  // String _fmt(DateTime d) {
  //   const months = ['січ', 'лют', 'бер', 'кві', 'тра', 'чер', 'лип', 'сер', 'вер', 'жов', 'лис', 'гру'];
  //   return '${d.day} ${months[d.month - 1]} ${d.year}';
  // }
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