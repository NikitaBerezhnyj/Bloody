import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/donation.dart';
import '../services/donation_service.dart';
import '../l10n/app_localizations.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<Donation> _donations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDonations();
  }

  Future<void> _loadDonations() async {
    final donations = await DonationService.getDonations();
    setState(() {
      _donations = donations;
      _isLoading = false;
    });
  }

  int _countByType(String type) {
    return _donations.where((d) => d.type == type).length;
  }

  double _averageInterval() {
    if (_donations.length < 2) return 0;
    _donations.sort((a, b) => a.date.compareTo(b.date));
    int totalDays = 0;
    for (int i = 1; i < _donations.length; i++) {
      totalDays += _donations[i].date.difference(_donations[i - 1].date).inDays;
    }
    return totalDays / (_donations.length - 1);
  }

  Map<int, int> _donationsPerMonth() {
    Map<int, int> data = {};
    for (var d in _donations) {
      int month = d.date.month;
      data[month] = (data[month] ?? 0) + 1;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(t.statsTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _donations.isEmpty
          ? Center(child: Text(t.noDonationsStats))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.totalDonations(_donations.length)),
                    const SizedBox(height: 8),
                    Text("${t.donationWholeBlood}: ${_countByType("donationWholeBlood")}, "
                        "${t.donationPlasma}: ${_countByType("donationPlasma")}, "
                        "${t.donationPlatelets}: ${_countByType("donationPlatelets")}"),

                    const SizedBox(height: 8),
                    Text(t.averageInterval(_averageInterval().toStringAsFixed(0))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              t.donationsPerMonth,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (_donationsPerMonth().values.isEmpty
                      ? 1
                      : _donationsPerMonth().values.reduce((a, b) => a > b ? a : b))
                      .toDouble() +
                      1,
                  barGroups: _donationsPerMonth()
                      .entries
                      .map((e) => BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value.toDouble(),
                        color: Colors.red,
                        width: 16,
                        borderRadius: BorderRadius.circular(4),
                      )
                    ],
                  ))
                      .toList(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, interval: 1),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
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
                            padding: const EdgeInsets.only(top: 8.0),
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
      ),
    );
  }
}
