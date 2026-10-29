import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/common/header.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final List<({String title, List<String> items, IconData icon})>
    recommendations = [
      (
        title: t.recBeforeDonation,
        icon: Icons.water_drop_outlined,
        items: [
          t.recBeforeDonation1,
          t.recBeforeDonation2,
          t.recBeforeDonation3,
          t.recBeforeDonation4,
          t.recBeforeDonation5,
          t.recBeforeDonation6,
        ],
      ),
      (
        title: t.recAfterDonation,
        icon: Icons.healing_outlined,
        items: [
          t.recAfterDonation1,
          t.recAfterDonation2,
          t.recAfterDonation3,
          t.recAfterDonation4,
          t.recAfterDonation5,
        ],
      ),
      (
        title: t.recNutrition,
        icon: Icons.restaurant_outlined,
        items: [
          t.recNutrition1,
          t.recNutrition2,
          t.recNutrition3,
          t.recNutrition4,
          t.recNutrition5,
        ],
      ),
      (
        title: t.recRestrictions,
        icon: Icons.block_outlined,
        items: [
          t.recRestrictions1,
          t.recRestrictions2,
          t.recRestrictions3,
          t.recRestrictions4,
          t.recRestrictions5,
          t.recRestrictions6,
        ],
      ),
    ];

    return Scaffold(
      appBar: AppHeader(title: t.recommendationsTitle, showBackButton: true),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        itemCount: recommendations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final section = recommendations[index];
          return _RecommendationCard(section: section);
        },
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final ({String title, List<String> items, IconData icon}) section;

  const _RecommendationCard({required this.section});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    section.icon,
                    color: colorScheme.onPrimaryContainer,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    section.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...section.items.map(
              (advice) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(advice, style: theme.textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
