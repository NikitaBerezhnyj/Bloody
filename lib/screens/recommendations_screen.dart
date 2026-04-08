import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/common/header.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final List<({String title, List<String> items, IconData icon, Color color})>
    recommendations = [
      (
      title: t.recBeforeDonation,
      icon: Icons.water_drop_outlined,
      color: Colors.blue,
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
      color: Colors.green,
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
      color: Colors.orange,
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
      color: Colors.red,
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
      appBar: AppHeader(
        title: t.recommendationsTitle,
        showBackButton: true,
      ),
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
  final ({
  String title,
  List<String> items,
  IconData icon,
  Color color,
  }) section;

  const _RecommendationCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: section.color.withOpacity(0.25),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: section.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(section.icon, color: section.color, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  section.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 10),
            ...section.items.map(
                  (advice) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 18,
                      color: section.color,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        advice,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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