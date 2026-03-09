import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/days_left_provider.dart';
import '../providers/donations_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/donation_permission_dialog.dart';
import 'profile_screen.dart';
import 'journal_screen.dart';
import 'stats_screen.dart';
import 'add_donation.dart';
import '../widgets/home_banner.dart';
import '../l10n/app_localizations.dart';
import '../screens/settings_screen.dart';
import 'achievements_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

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
        if (hasPermission != true) return;
      }
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddDonationScreen()),
      );

      ref.invalidate(donationsProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.opacity, color: Colors.red, size: 36),
            SizedBox(width: 8),
            Text('Bloody'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: t.profile,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.welcomeUser(userName),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            HomeBanner(
              daysLeft: daysLeft,
              hasDonations: hasDonations,
              userStats: userStats,
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1.5),
            const SizedBox(height: 16),
            if (requiresAgeConfirmation)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.warning_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t.ageLimitBanner,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            _NavCard(
              icon: Icons.person,
              label: t.profileTitle,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
            _NavCard(
              icon: Icons.list_alt,
              label: t.journalTitle,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const JournalScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _NavCard(
              icon: Icons.bar_chart,
              label: t.statsTitle,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StatsScreen()),
              ),
            ),
            _NavCard(
              icon: Icons.celebration,
              label: t.achievementsTitle,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AchievementsScreen()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 45.0),
        child: FloatingActionButton(
          onPressed: daysLeft > 0 ? null : addDonation,
          tooltip: daysLeft > 0 ? t.tooEarlyToDonate : t.addDonation,
          backgroundColor: daysLeft > 0 ? Colors.red.shade200 : Colors.red,
          foregroundColor: Colors.white,
          elevation: daysLeft > 0 ? 2 : 6,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class _NavCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _NavCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [Icon(icon), const SizedBox(width: 16), Text(label)],
          ),
        ),
      ),
    );
  }
}
