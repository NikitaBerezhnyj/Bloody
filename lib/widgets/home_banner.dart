import 'dart:math';
import 'package:flutter/material.dart';
import 'package:bloody/l10n/app_localizations.dart';

class UserStats {
  final String name;
  final int age;
  final int donationsCount;
  final int daysSinceLastDonation;

  UserStats({
    required this.name,
    required this.age,
    required this.donationsCount,
    required this.daysSinceLastDonation,
  });
}

class HomeBanner extends StatefulWidget {
  final int daysLeft;
  final bool hasDonations;
  final UserStats? userStats;

  const HomeBanner({
    super.key,
    required this.daysLeft,
    required this.hasDonations,
    this.userStats,
  });

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  String _generateMessage(UserStats stats) {
    final t = AppLocalizations.of(context)!;

    final messages = [
      t.motivational1(stats.donationsCount, stats.donationsCount * 3),
      t.motivational2(stats.donationsCount, stats.donationsCount * 3),
      t.motivational3(stats.name, stats.donationsCount),
      t.motivational4(stats.donationsCount, stats.name),
      t.motivational5(stats.name, stats.daysSinceLastDonation),
      t.motivational6(stats.name),
      t.motivational7(stats.name),
      t.motivational8,
      t.motivational9(stats.name),
    ];

    final random = Random();
    return messages[random.nextInt(messages.length)];
  }

  @override
  Widget build(BuildContext context) {
    final bannersCount = widget.hasDonations ? 2 : 1;
    final motivationalMessage = (widget.hasDonations && widget.userStats != null)
        ? _generateMessage(widget.userStats!)
        : "";

    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              Card(
                color: Colors.red.shade100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 40),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          widget.daysLeft > 0
                              ? AppLocalizations.of(context)!.cannotDonate(widget.daysLeft)
                              : AppLocalizations.of(context)!.canDonate,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.hasDonations && widget.userStats != null)
                Card(
                  color: Colors.orange.shade100,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_events, color: Colors.orange, size: 40),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            motivationalMessage,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (widget.hasDonations)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(bannersCount, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 12 : 8,
                height: _currentPage == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.red : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
      ],
    );
  }
}
