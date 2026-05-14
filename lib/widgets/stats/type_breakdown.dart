import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';

class TypeBreakdown extends StatelessWidget {
  final DonationStats stats;
  final AppLocalizations t;
  const TypeBreakdown({required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    final items = <({Color color, String label, int count})>[];
    if (stats.wholeBlood > 0) items.add((color: Colors.red, label: t.donationWholeBlood, count: stats.wholeBlood));
    if (stats.plasma > 0) items.add((color: Colors.red.shade300, label: t.donationPlasma, count: stats.plasma));
    if (stats.platelets > 0) items.add((color: Colors.red.shade200, label: t.donationPlatelets, count: stats.platelets));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(item.label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ),
            Text(
              '${item.count}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      )).toList(),
    );
  }
}