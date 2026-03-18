import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/donations_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/date_formatters.dart';
import '../utils/donation_labels.dart';
import '../widgets/common/button.dart';
import '../widgets/common/header.dart';
import '../widgets/donation/detail_card.dart';
import '../widgets/common/detail_row.dart';
import 'add_donation_screen.dart';

class DonationDetailScreen extends ConsumerWidget {
  final int donationId;

  const DonationDetailScreen({
    super.key,
    required this.donationId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    final donations = ref.watch(donationsProvider).value ?? [];
    final donation = donations.firstWhere((d) => d.id == donationId);
    final d = donation;

    final dateStr = formatDate(d.date);
    final timeStr = formatTime(d.time);

    return Scaffold(
      appBar: AppHeader(
        title: t.detailsView,
        showBackButton: true,
        action: IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddDonationScreen(existing: donation),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      typeIcon(d.type),
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    typeLabel(t, d.type),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$dateStr  •  $timeStr',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            DetailCard(
              children: [
                DetailRow(
                  icon: Icons.calendar_today,
                  label: t.date,
                  value: dateStr,
                ),
                DetailRow(
                  icon: Icons.access_time,
                  label: t.time,
                  value: timeStr,
                ),
                DetailRow(
                  icon: typeIcon(d.type),
                  label: t.donationType,
                  value: typeLabel(t, d.type),
                ),
                DetailRow(
                  icon: Icons.mood,
                  label: t.feeling,
                  value: feelingLabelWithEmoji(t, d.feeling),
                ),
                if (d.notes.isNotEmpty)
                  DetailRow(
                    icon: Icons.notes,
                    label: t.notes,
                    value: d.notes,
                  ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: OutlineButton(
          label: t.deleteDonation,
          onPressed: () => _confirmAndDelete(context, ref),
        ),
      ),
    );
  }

  Future<void> _confirmAndDelete(BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context)!;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.deleteDonationTitle),
        content: Text(t.deleteDonationContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.delete),
          ),
        ],
      ),
    );

    if (confirm != true || !context.mounted) return;

    await ref.read(donationsProvider.notifier).delete(donationId);

    if (!context.mounted) return;

    Navigator.pop(context);
  }
}