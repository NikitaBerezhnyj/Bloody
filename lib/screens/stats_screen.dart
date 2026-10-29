import 'package:bloody/widgets/stats/hero_section.dart';
import 'package:bloody/widgets/stats/summary_section.dart';
import 'package:bloody/widgets/stats/type_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../models/donation_stats.dart';
import '../providers/donations_provider.dart';
import '../widgets/common/header.dart';
import '../widgets/stats/details_section.dart';
import '../widgets/stats/years_section.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final donationsAsync = ref.watch(donationsProvider);

    return Scaffold(
      appBar: AppHeader(title: t.statsTitle, showBackButton: true),
      body: donationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${t.error}: $e')),
        data: (donations) {
          if (donations.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: colorScheme.primary,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(t.noDonations, textAlign: TextAlign.center),
                ],
              ),
            );
          }

          final stats = DonationStats.from(donations);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              SummarySection(stats: stats, t: t),
              const SizedBox(height: 24),
              YearsSection(donations: donations, t: t),
              const SizedBox(height: 24),
              DetailsSection(stats: stats, t: t),
            ],
          );
        },
      ),
    );
  }
}
