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
    if (stats.wholeBlood > 0) {
      items.add((
      icon: Icons.bloodtype,
      label: t.statsTypeWhole,
      count: stats.wholeBlood,
      ));
    }
    if (stats.plasma > 0) {
      items.add((
      icon: Icons.opacity,
      label: t.statsTypePlasma,
      count: stats.plasma,
      ));
    }
    if (stats.platelets > 0) {
      items.add((
      icon: Icons.healing,
      label: t.statsTypePlatelets,
      count: stats.platelets,
      ));
    }

    if (items.length <= 1) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: Colors.white54, size: 13),
            const SizedBox(width: 4),
            Text(
              '${item.count} ${item.label}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}