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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final showStats = widget.hasDonations && widget.userStats != null;
    final message = showStats ? _generateMessage(widget.userStats!) : '';
    final pages = showStats ? 2 : 1;

    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PageView(
            controller: _controller,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [
              _BannerCard(
                icon: Icons.favorite,
                text: widget.daysLeft > 0
                    ? t.cannotDonate(widget.daysLeft)
                    : t.canDonate,
                highlighted: true,
              ),
              if (showStats)
                _BannerCard(icon: Icons.emoji_events, text: message),
            ],
          ),
        ),
        if (pages > 1) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == _currentPage ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == _currentPage
                      ? colorScheme.primary
                      : colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool highlighted;

  const _BannerCard({
    required this.icon,
    required this.text,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: highlighted ? colorScheme.primaryContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: highlighted
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: highlighted
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
