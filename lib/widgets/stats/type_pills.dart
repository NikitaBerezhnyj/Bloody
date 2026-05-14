import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';

class TypePills extends StatelessWidget {
  final DonationStats stats;
  final AppLocalizations t;
  const TypePills({required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String label, int count})>[];
    if (stats.wholeBlood > 0) items.add((icon: Icons.bloodtype_outlined, label: t.donationWholeBlood, count: stats.wholeBlood));
    if (stats.plasma > 0) items.add((icon: Icons.opacity_outlined, label: t.donationPlasma, count: stats.plasma));
    if (stats.platelets > 0) items.add((icon: Icons.healing_outlined, label: t.donationPlatelets, count: stats.platelets));

    if (items.isEmpty) return const SizedBox();

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: items.map((item) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.07),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: Colors.red, size: 13),
            const SizedBox(width: 5),
            Text(
              '${item.count} ${item.label}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}