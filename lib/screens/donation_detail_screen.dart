import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donation.dart';
import '../providers/donations_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/donation_formatters.dart';
import '../utils/donation_type.dart';
import '../widgets/common/button.dart';
import '../widgets/common/header.dart';
import 'add_donation_screen.dart';

class DonationDetailScreen extends ConsumerWidget {
  final Donation donation;

  const DonationDetailScreen({
    super.key,
    required this.donation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final d = donation;

    final dateStr = formatDate(d.date);
    final timeStr = formatTime(d.time);

    return Scaffold(
      appBar: AppHeader(
        title: t.detailsView,
        showBackButton: true,
        action: IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => Navigator.pushReplacement(
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
                    translateType(t, d.type),
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

            _DetailCard(
              children: [
                _DetailRow(
                  icon: Icons.calendar_today,
                  label: t.date,
                  value: dateStr,
                ),
                _DetailRow(
                  icon: Icons.access_time,
                  label: t.donationTime,
                  value: timeStr,
                ),
                _DetailRow(
                  icon: typeIcon(d.type),
                  label: t.donationType,
                  value: translateType(t, d.type),
                ),
                _DetailRow(
                  icon: Icons.mood,
                  label: t.feeling,
                  value: translateFeeling(t, d.feeling),
                ),
                if (d.notes.isNotEmpty)
                  _DetailRow(
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

    await ref.read(donationsProvider.notifier).delete(donation.id!);

    if (!context.mounted) return;

    Navigator.pop(context);
  }
}

class _DetailCard extends StatelessWidget {
  final List<Widget> children;

  const _DetailCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: children
              .expand((w) => [w, const Divider(height: 1, indent: 56)])
              .toList()
            ..removeLast(),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.red),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}