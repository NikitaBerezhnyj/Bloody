import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/donation.dart';
import '../l10n/app_localizations.dart';
import '../providers/donations_provider.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  int _countByType(List<Donation> d, String type) =>
      d.where((x) => x.type == type).length;

  double _averageInterval(List<Donation> donations) {
    if (donations.length < 2) return 0;
    final sorted = [...donations]..sort((a, b) => a.date.compareTo(b.date));
    int total = 0;
    for (int i = 1; i < sorted.length; i++) {
      total += sorted[i].date.difference(sorted[i - 1].date).inDays;
    }
    return total / (sorted.length - 1);
  }

  Map<int, int> _perMonth(List<Donation> donations) {
    final data = <int, int>{};
    for (final d in donations) {
      data[d.date.month] = (data[d.date.month] ?? 0) + 1;
    }
    return data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final donationsAsync = ref.watch(donationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.statsTitle)),
      body: donationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Помилка: $e')),
        data: (donations) {
          if (donations.isEmpty) {
            return Center(child: Text(t.noDonationsStats));
          }
          final perMonth = _perMonth(donations);
          final maxY = perMonth.values.isEmpty
              ? 1.0
              : perMonth.values.reduce((a, b) => a > b ? a : b).toDouble() + 1;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.totalDonations(donations.length)),
                        const SizedBox(height: 8),
                        Text(
                          "${t.donationWholeBlood}: ${_countByType(donations, "donationWholeBlood")}, "
                          "${t.donationPlasma}: ${_countByType(donations, "donationPlasma")}, "
                          "${t.donationPlatelets}: ${_countByType(donations, "donationPlatelets")}",
                        ),
                        const SizedBox(height: 8),
                        Text(
                          t.averageInterval(
                            _averageInterval(donations).toStringAsFixed(0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  t.donationsPerMonth,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,
                      barGroups: perMonth.entries
                          .map(
                            (e) => BarChartGroupData(
                              x: e.key,
                              barRods: [
                                BarChartRodData(
                                  toY: e.value.toDouble(),
                                  color: Colors.red,
                                  width: 16,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, interval: 1),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              final months = [
                                '',
                                t.month1,
                                t.month2,
                                t.month3,
                                t.month4,
                                t.month5,
                                t.month6,
                                t.month7,
                                t.month8,
                                t.month9,
                                t.month10,
                                t.month11,
                                t.month12,
                              ];
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(months[value.toInt()]),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
