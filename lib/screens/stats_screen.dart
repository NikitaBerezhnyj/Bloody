import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../providers/donations_provider.dart';
import '../models/donation.dart';

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
      appBar: AppBar(title: Text(t.statsTitle)),
      body: donationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Помилка: $e')),
        data: (donations) {
          if (donations.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border,
                      color: Colors.red.shade200, size: 64),
                  const SizedBox(height: 16),
                  Text(t.noDonationsStats,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          final stats = _DonationStats.from(donations);
          _selectedYear ??= DateTime.now().year;
          if (!stats.availableYears.contains(_selectedYear)) {
            _selectedYear = stats.availableYears.last;
          }
          final yearStats = _DonationStats.forYear(donations, _selectedYear!);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [

              // ── Hero: загальна кількість ──────────────────────────
              _HeroSection(stats: stats, t: t),
              const SizedBox(height: 24),

              // ── По роках ─────────────────────────────────────────
              _YearSection(
                selectedYear: _selectedYear!,
                availableYears: stats.availableYears,
                yearStats: yearStats,
                t: t,
                onYearChanged: (y) => setState(() => _selectedYear = y),
              ),
              const SizedBox(height: 24),

              // ── Деталі (середній інтервал + остання донація) ──────
              _DetailsSection(stats: stats, t: t),
            ],
          );
        },
      ),
    );
  }
}

// ─── Hero Section ─────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final _DonationStats stats;
  final AppLocalizations t;
  const _HeroSection({required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Велике число
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${stats.total}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  t.statsTotalDonations, // "донацій"
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Розділювач
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 16),
          // Нижній рядок: врятовано + розбивка по типах
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '≈${stats.total * 3}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    t.statsLivesLabel, // "людей врятовано"
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Типи донацій (тільки ненульові)
              _TypePills(stats: stats, t: t),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypePills extends StatelessWidget {
  final _DonationStats stats;
  final AppLocalizations t;
  const _TypePills({required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String label, int count})>[];
    if (stats.wholeBlood > 0) {
      items.add((
      icon: Icons.bloodtype,
      label: t.statsTypeWhole, // "Цільна"
      count: stats.wholeBlood,
      ));
    }
    if (stats.plasma > 0) {
      items.add((
      icon: Icons.opacity,
      label: t.statsTypePlasma, // "Плазма"
      count: stats.plasma,
      ));
    }
    if (stats.platelets > 0) {
      items.add((
      icon: Icons.healing,
      label: t.statsTypePlatelets, // "Тромбоцити"
      count: stats.platelets,
      ));
    }

    // показуємо тільки якщо більше одного типу
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

// ─── Year Section ─────────────────────────────────────────────────────────────

class _YearSection extends StatelessWidget {
  final int selectedYear;
  final List<int> availableYears;
  final _DonationStats yearStats;
  final AppLocalizations t;
  final ValueChanged<int> onYearChanged;

  const _YearSection({
    required this.selectedYear,
    required this.availableYears,
    required this.yearStats,
    required this.t,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    final idx     = availableYears.indexOf(selectedYear);
    final canPrev = idx > 0;
    final canNext = idx < availableYears.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Заголовок секції + навігація роками в одному рядку
        Row(
          children: [
            Text(
              t.statsPerYear, // "По роках"
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            _YearNavButton(
              icon: Icons.chevron_left,
              enabled: canPrev,
              onTap: canPrev ? () => onYearChanged(availableYears[idx - 1]) : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '$selectedYear',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _YearNavButton(
              icon: Icons.chevron_right,
              enabled: canNext,
              onTap: canNext ? () => onYearChanged(availableYears[idx + 1]) : null,
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Картка року
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.shade100, width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${yearStats.total}',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    t.statsDonationsYear, // "донацій за рік"
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Розбивка по типах у році
              if (yearStats.total > 0)
                _YearTypeBreakdown(stats: yearStats, t: t),
            ],
          ),
        ),
      ],
    );
  }
}

class _YearNavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;
  const _YearNavButton({
    required this.icon,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: enabled ? Colors.red : Colors.grey.shade300,
        size: 28,
      ),
    );
  }
}

class _YearTypeBreakdown extends StatelessWidget {
  final _DonationStats stats;
  final AppLocalizations t;
  const _YearTypeBreakdown({required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stats.wholeBlood > 0)
          _TypeRow(
            icon: Icons.bloodtype,
            color: Colors.red,
            label: t.statsTypeWhole,
            count: stats.wholeBlood,
          ),
        if (stats.plasma > 0)
          _TypeRow(
            icon: Icons.opacity,
            color: Colors.red.shade300,
            label: t.statsTypePlasma,
            count: stats.plasma,
          ),
        if (stats.platelets > 0)
          _TypeRow(
            icon: Icons.healing,
            color: Colors.red.shade200,
            label: t.statsTypePlatelets,
            count: stats.platelets,
          ),
      ],
    );
  }
}

class _TypeRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final int count;
  const _TypeRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 15),
          const SizedBox(width: 6),
          Text(
            '$count  $label',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// ─── Details Section ──────────────────────────────────────────────────────────

class _DetailsSection extends StatelessWidget {
  final _DonationStats stats;
  final AppLocalizations t;
  const _DetailsSection({required this.stats, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.statsDetails, // "Деталі"
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _DetailRow(
                icon: Icons.history,
                label: t.statsLastDonation, // "Остання донація"
                value: stats.lastDonationDate,
                trailing: _daysAgoText(stats.daysSinceLast, t),
              ),
              if (stats.avgIntervalDays > 0) ...[
                Divider(
                  height: 1,
                  indent: 52,
                  color: Colors.grey.shade200,
                ),
                _DetailRow(
                  icon: Icons.timer_outlined,
                  label: t.statsAvgInterval, // "Середній інтервал"
                  value: '${stats.avgIntervalDays} ${t.statsDays}', // "днів"
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _daysAgoText(int days, AppLocalizations t) {
    if (days == 0) return t.statsToday;
    if (days == 1) return t.statsYesterday;
    final n  = days % 100;
    final n1 = days % 10;
    if (n >= 11 && n <= 19) return t.statsDaysAgoMany(days);
    if (n1 == 1)            return t.statsDaysAgo1(days);
    if (n1 >= 2 && n1 <= 4) return t.statsDaysAgo2(days);
    return t.statsDaysAgoMany(days);
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? trailing;
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 20),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (trailing != null) ...[
            const Spacer(),
            Text(
              trailing!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Stats Model ──────────────────────────────────────────────────────────────

class _DonationStats {
  final int total;
  final int wholeBlood;
  final int plasma;
  final int platelets;
  final int avgIntervalDays;
  final String lastDonationDate;
  final int daysSinceLast;
  final List<int> availableYears;

  const _DonationStats({
    required this.total,
    required this.wholeBlood,
    required this.plasma,
    required this.platelets,
    required this.avgIntervalDays,
    required this.lastDonationDate,
    required this.daysSinceLast,
    required this.availableYears,
  });

  factory _DonationStats.from(List<Donation> donations) =>
      _compute(donations, donations);

  factory _DonationStats.forYear(List<Donation> all, int year) =>
      _compute(all.where((d) => d.date.year == year).toList(), all);

  static _DonationStats _compute(
      List<Donation> donations,
      List<Donation> all,
      ) {
    final now        = DateTime.now();
    final total      = donations.length;
    final wholeBlood = donations.where((d) => d.type == 'donationWholeBlood').length;
    final plasma     = donations.where((d) => d.type == 'donationPlasma').length;
    final platelets  = donations.where((d) => d.type == 'donationPlatelets').length;
    final years      = all.map((d) => d.date.year).toSet().toList()..sort();

    int avg = 0;
    if (donations.length >= 2) {
      final sorted = [...donations]..sort((a, b) => a.date.compareTo(b.date));
      int sum = 0;
      for (int i = 1; i < sorted.length; i++) {
        sum += sorted[i].date.difference(sorted[i - 1].date).inDays;
      }
      avg = sum ~/ (sorted.length - 1);
    }

    final last = all.first;
    final lastDate =
        "${last.date.day.toString().padLeft(2, '0')}.${last.date.month.toString().padLeft(2, '0')}.${last.date.year}";

    return _DonationStats(
      total: total,
      wholeBlood: wholeBlood,
      plasma: plasma,
      platelets: platelets,
      avgIntervalDays: avg,
      lastDonationDate: lastDate,
      daysSinceLast: now.difference(last.date).inDays,
      availableYears: years,
    );
  }
}