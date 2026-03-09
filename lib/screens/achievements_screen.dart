import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/achievements_provider.dart';
import '../widgets/achievement_tile.dart';
import '../l10n/app_localizations.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;
    final achievementsAsync = ref.watch(achievementsProvider(localeCode));

    return Scaffold(
      appBar: AppBar(title: Text(t.achievementsTitle)),
      body: achievementsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Помилка: $e')),
        data: (achievements) => ListView(
          padding: const EdgeInsets.all(16),
          children: achievements.entries.map((entry) {
            final category = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                LayoutBuilder(builder: (context, constraints) {
                  const columns = 3;
                  const spacing = 16.0;
                  final tileWidth =
                      (constraints.maxWidth - spacing * (columns - 1)) /
                          columns;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: category.achievements
                        .map<Widget>((a) => SizedBox(
                      width: tileWidth,
                      child: AchievementTile(
                        icon: a.icon ?? category.icon,
                        title: a.title,
                        subtitle: a.level?.toString() ?? "",
                        description: a.description ?? "",
                        achieved: a.achieved,
                      ),
                    ))
                        .toList(),
                  );
                }),
                const SizedBox(height: 24),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}