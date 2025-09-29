import 'package:flutter/material.dart';
import '../widgets/achievement_tile.dart';
import '../services/achievement_service.dart';
import '../l10n/app_localizations.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  Map<String, AchievementCategory>? achievements;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isLoading) {
      _loadAchievements();
    }
  }

  Future<void> _loadAchievements() async {
    final t = AppLocalizations.of(context)!;
    final data = await AchievementService.getAchievements(t);
    if (mounted) {
      setState(() {
        achievements = data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.achievementsTitle),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : achievements == null
          ? const Center(child: Text('No data'))
          : ListView(
        padding: const EdgeInsets.all(16),
        children: achievements!.entries.map((entry) {
          final category = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  const tileWidth = 100.0;
                  const minSpacing = 16.0;
                  final availableWidth = constraints.maxWidth;

                  int columns = (availableWidth / (tileWidth + minSpacing)).floor();
                  columns = columns.clamp(2, 4);

                  final totalTileWidth = tileWidth * columns;
                  final totalSpacing = availableWidth - totalTileWidth;
                  final spacing = totalSpacing / (columns + 1);

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 16,
                    children: category.achievements.map<Widget>((achievement) {
                      return SizedBox(
                        width: tileWidth,
                        child: AchievementTile(
                          icon: category.icon,
                          title: achievement.title,
                          subtitle: achievement.level.toString(),
                          achieved: achievement.achieved,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          );
        }).toList(),
      ),
    );
  }
}