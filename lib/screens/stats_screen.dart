import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../models/donation_stats.dart';
import '../providers/donations_provider.dart';
import '../widgets/common/header.dart';
import '../widgets/stats/details_section.dart';
import '../widgets/stats/hero_section.dart';
import '../widgets/stats/year_section.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  int? _selectedYear;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final donationsAsync = ref.watch(donationsProvider);

    return Scaffold(
      appBar: AppHeader(
        title: t.statsTitle,
        showBackButton: true,
      ),
      body: donationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${t.error}: $e')),
        data: (donations) {
          if (donations.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border,
                      color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    t.noDonations,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }

          final stats = DonationStats.from(donations);
          _selectedYear ??= DateTime.now().year;
          if (!stats.availableYears.contains(_selectedYear)) {
            _selectedYear = stats.availableYears.last;
          }
          final yearStats = DonationStats.forYear(donations, _selectedYear!);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [

              HeroSection(stats: stats, t: t),
              const SizedBox(height: 24),

              YearSection(
                selectedYear: _selectedYear!,
                availableYears: stats.availableYears,
                yearStats: yearStats,
                t: t,
                onYearChanged: (y) => setState(() => _selectedYear = y),
              ),
              const SizedBox(height: 24),

              DetailsSection(stats: stats, t: t),
            ],
          );
        },
      ),
    );
  }
}