import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../services/calculation_service.dart';
import '../services/donation_service.dart';
import '../models/user.dart';
import '../widgets/donation_permission_dialog.dart';
import 'profile_screen.dart';
import 'journal_screen.dart';
import 'stats_screen.dart';
import 'add_donation.dart';
import '../widgets/home_banner.dart';
import '../l10n/app_localizations.dart';
import '../screens/settings_screen.dart';
import 'achievements_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale) onLocaleChanged;
  const HomeScreen({super.key, required this.onLocaleChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  int daysLeft = 0;
  bool hasDonations = false;
  List<dynamic> donations = [];
  bool hasDonationPermission = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _calculateDaysLeft();
  }

  Future<void> _calculateDaysLeft() async {
    final fetchedDonations = await DonationService.getDonations();
    final days = await CalculationService.calculateDaysLeft(fetchedDonations);
    setState(() {
      donations = fetchedDonations;
      daysLeft = days;
      hasDonations = donations.isNotEmpty;
    });
  }

  Future<void> _loadUserData() async {
    final loadedUser = await UserService.getUser();
    setState(() {
      user = loadedUser;
      hasDonationPermission = (user?.age ?? 0) >= 65;
    });
  }

  UserStats? get userStats {
    if (user == null) return null;
    return UserStats(
      name: user!.name,
      age: user!.age,
      donationsCount: donations.length,
      daysSinceLastDonation: donations.isNotEmpty
          ? DateTime
          .now()
          .difference(donations.last.date)
          .inDays
          : 0,
    );
  }

  void _openJournal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const JournalScreen()),
    );
  }

  void _openStats() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StatsScreen()),
    );
  }

  void _openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(onLocaleChanged: widget.onLocaleChanged),
      ),
    );
  }

  void _openAchievements() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AchievementsScreen()),
    );
  }

  void _addDonation() async {
    if (user == null) return;

    if (hasDonationPermission) {
      final hasPermission = await showDialog<bool>(
        context: context,
        builder: (context) => const DonationPermissionDialog(),
      );

      if (hasPermission != true) return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddDonationScreen()),
    ).then((_) {
      setState(() {
        _calculateDaysLeft();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final userName = user?.name ?? "...";

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.opacity, color: Colors.red, size: 36),
            const SizedBox(width: 8),
            const Text("Bloody"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: t.profile,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SettingsScreen(onLocaleChanged: widget.onLocaleChanged),
                ),
              );
            },
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
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
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

            if (hasDonationPermission)
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
                    const Icon(Icons.warning_rounded,
                        color: Colors.white, size: 28),
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

            GestureDetector(
              onTap: _openProfile,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(width: 16),
                      Text(t.profileTitle),
                    ],
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: _openJournal,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.list_alt),
                      const SizedBox(width: 16),
                      Text(t.journalTitle),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: _openStats,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.bar_chart),
                      const SizedBox(width: 16),
                      Text(t.statsTitle),
                    ],
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: _openAchievements,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.celebration),
                      const SizedBox(width: 16),
                      Text(t.achievementsTitle),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 45.0),
        child: FloatingActionButton(
          onPressed: daysLeft > 0 ? null : _addDonation,
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