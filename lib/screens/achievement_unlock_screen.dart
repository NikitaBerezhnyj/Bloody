import 'package:bloody/widgets/common/button.dart';
import 'package:flutter/material.dart';
import '../models/unlocked_achievement.dart';
import '../l10n/app_localizations.dart';
import 'achievements_screen.dart';

class AchievementUnlockScreen extends StatefulWidget {
  final List<UnlockedAchievement> achievements;
  final VoidCallback? onDone;

  const AchievementUnlockScreen({
    super.key,
    required this.achievements,
    this.onDone,
  });

  @override
  State<AchievementUnlockScreen> createState() =>
      _AchievementUnlockScreenState();
}

class _AchievementUnlockScreenState extends State<AchievementUnlockScreen>
    with SingleTickerProviderStateMixin {

  late final PageController _pageController;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToAllAchievements() {
    if (widget.onDone != null) {
      widget.onDone!();
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AchievementsScreen()),
            (route) => route.isFirst,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final total = widget.achievements.length;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              if (total > 1) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    total,
                        (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],

              const Spacer(),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.achievements.length,
                  onPageChanged: (i) {
                    setState(() => _index = i);
                  },
                  itemBuilder: (context, i) {
                    final a = widget.achievements[i];

                    return Center(
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(24),

                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      a.icon,
                                      size: 64,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  Text(
                                    t.achievementUnlocked,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    a.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  if (a.description.isNotEmpty) ...[
                                    const SizedBox(height: 12),
                                    Text(
                                      a.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Spacer(),

              PrimaryButton(
                onPressed: _goToAllAchievements,
                label: t.viewAllAchievements,
              ),

              const SizedBox(height: 8),

              NoBorderButton(
                onPressed: () => Navigator.pop(context),
                label: t.notNow,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}