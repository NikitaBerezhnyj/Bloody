import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/donation.dart';
import '../../utils/donation_labels.dart';
import '../common/detail_row.dart';
import '../common/section_label.dart';
import '../donation/detail_card.dart';

class YearsSection extends StatefulWidget {
  final List<Donation> donations;
  final AppLocalizations t;

  const YearsSection({super.key, required this.donations, required this.t});

  @override
  State<YearsSection> createState() => _YearsSectionState();
}

class _YearsSectionState extends State<YearsSection> {
  int? _selectedYear;

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final years = widget.donations.map((d) => d.date.year).toSet().toList()
      ..sort();
    final year = years.contains(_selectedYear) ? _selectedYear! : years.last;
    final idx = years.indexOf(year);

    final yearDonations = widget.donations
        .where((d) => d.date.year == year)
        .toList();
    final types = ['donationWholeBlood', 'donationPlasma', 'donationPlatelets']
        .map((key) => (key, yearDonations.where((d) => d.type == key).length))
        .where((e) => e.$2 > 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label: t.statsPerYear),
        const SizedBox(height: 8),
        DetailCard(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text('$year', style: theme.textTheme.titleMedium),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: idx > 0
                        ? () => setState(() => _selectedYear = years[idx - 1])
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: idx < years.length - 1
                        ? () => setState(() => _selectedYear = years[idx + 1])
                        : null,
                  ),
                ],
              ),
            ),
            for (final (key, count) in types)
              DetailRow(
                icon: typeIcon(key),
                label: typeLabel(t, key),
                value: '$count',
              ),
          ],
        ),
      ],
    );
  }
}
