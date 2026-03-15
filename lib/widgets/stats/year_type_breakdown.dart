import 'package:bloody/widgets/stats/type_row.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation_stats.dart';

class YearTypeBreakdown extends StatelessWidget {
  final DonationStats stats;
  final AppLocalizations t;

  const YearTypeBreakdown({required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stats.wholeBlood > 0)
          TypeRow(
            icon: Icons.bloodtype,
            color: Colors.red,
            label: t.statsTypeWhole,
            count: stats.wholeBlood,
          ),
        if (stats.plasma > 0)
          TypeRow(
            icon: Icons.opacity,
            color: Colors.red.shade300,
            label: t.statsTypePlasma,
            count: stats.plasma,
          ),
        if (stats.platelets > 0)
          TypeRow(
            icon: Icons.healing,
            color: Colors.red.shade200,
            label: t.statsTypePlatelets,
            count: stats.platelets,
          ),
      ],
    );
  }
}