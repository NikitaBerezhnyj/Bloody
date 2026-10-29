import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/days_left_provider.dart';
import '../providers/donations_provider.dart';
import '../providers/user_provider.dart';
import '../services/widget_prompt_service.dart';
import '../widgets/common/header.dart';
import '../widgets/donation/donation_permission_dialog.dart';
import '../widgets/home/nav_card.dart';
import 'profile_screen.dart';
import 'journal_screen.dart';
import 'stats_screen.dart';
import 'recommendations_screen.dart';
import 'add_donation_screen.dart';
import '../widgets/home/home_banner.dart';
import '../l10n/app_localizations.dart';
import '../screens/settings_screen.dart';
import 'achievements_screen.dart';
import 'widget_prompt_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final shouldShow = await WidgetPromptService.shouldShow();
      if (!shouldShow || !mounted) return;

      await WidgetPromptService.markShown();
      if (!mounted) return;

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const WidgetPromptScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final userAsync = ref.watch(userProvider);
    final donationsAsync = ref.watch(donationsProvider);
    final daysLeftAsync = ref.watch(daysLeftProvider);

    final user = userAsync.valueOrNull;
    final donations = donationsAsync.valueOrNull ?? [];
    final daysLeft = daysLeftAsync.valueOrNull ?? 0;

    final hasDonations = donations.isNotEmpty;
    final requiresAgeConfirmation = (user?.age ?? 0) >= 65;
    final userName = user?.name ?? '...';

    UserStats? userStats;
    if (user != null) {
      userStats = UserStats(
        name: user.name,
        age: user.age,
        donationsCount: donations.length,
        daysSinceLastDonation: donations.isNotEmpty
            ? DateTime.now().difference(donations.last.date).inDays
            : 0,
      );
    }

    Future<void> addDonation() async {
      if (user == null) return;

      if (requiresAgeConfirmation) {
        final hasPermission = await showDialog<bool>(
          context: context,
          builder: (_) => const DonationPermissionDialog(),
        );

        if (!context.mounted || hasPermission != true) return;
      }

      if (!context.mounted) return;

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddDonationScreen()),
      );

      if (!context.mounted) return;

      ref.invalidate(donationsProvider);
    }

    return Scaffold(
      appBar: AppHeader(
        showSettingsButton: true,
        onSettings: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsScreen()),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          Text(t.welcomeUser(userName), style: theme.textTheme.headlineMedium),
          const SizedBox(height: 24),
          HomeBanner(
            daysLeft: daysLeft,
            hasDonations: hasDonations,
            userStats: userStats,
          ),
          const SizedBox(height: 24),
          if (requiresAgeConfirmation)
            Card(
              color: colorScheme.errorContainer,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t.ageLimitBanner,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          NavCard(
            icon: Icons.person,
            label: t.profileTitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
          NavCard(
            icon: Icons.list_alt,
            label: t.journalTitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const JournalScreen()),
            ),
          ),
          NavCard(
            icon: Icons.bar_chart,
            label: t.statsTitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StatsScreen()),
            ),
          ),
          NavCard(
            icon: Icons.celebration,
            label: t.achievementsTitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AchievementsScreen()),
            ),
          ),
          NavCard(
            icon: Icons.library_books_rounded,
            label: t.recommendationsTitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RecommendationsScreen()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: daysLeft > 0 ? null : addDonation,
        tooltip: daysLeft > 0 ? t.tooEarlyToDonate : t.addDonation,
        backgroundColor: daysLeft > 0
            ? colorScheme.surfaceContainerHighest
            : null,
        foregroundColor: daysLeft > 0 ? colorScheme.onSurfaceVariant : null,
        elevation: daysLeft > 0 ? 0 : null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
