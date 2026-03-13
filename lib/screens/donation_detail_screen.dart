import 'package:flutter/material.dart';
import '../models/donation.dart';
import '../l10n/app_localizations.dart';
import 'add_donation_screen.dart';

class DonationDetailScreen extends StatelessWidget {
  final Donation donation;
  const DonationDetailScreen({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final d = donation;

    final dateStr =
        "${d.date.day.toString().padLeft(2, '0')}.${d.date.month.toString().padLeft(2, '0')}.${d.date.year}";
    final timeStr =
        "${d.time.hour.toString().padLeft(2, '0')}:${d.time.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(
        title: Text(t.detailsView),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => AddDonationScreen(existing: d),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок з іконкою
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
                    child: Icon(_typeIcon(d.type), color: Colors.red, size: 40),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _translateType(t, d.type),
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

            // Деталі
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
                  icon: _typeIcon(d.type),
                  label: t.donationType,
                  value: _translateType(t, d.type),
                ),
                _DetailRow(
                  icon: Icons.mood,
                  label: t.feeling,
                  value: _translateFeeling(t, d.feeling),
                ),
                if (d.notes.isNotEmpty)
                  _DetailRow(
                    icon: Icons.notes,
                    label: t.notes,
                    value: d.notes,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _translateType(AppLocalizations t, String key) {
    switch (key) {
      case 'donationWholeBlood': return t.donationWholeBlood;
      case 'donationPlasma':     return t.donationPlasma;
      case 'donationPlatelets':  return t.donationPlatelets;
      default:                   return key;
    }
  }

  String _translateFeeling(AppLocalizations t, String key) {
    switch (key) {
      case 'feelingGood':   return '😃 ${t.feelingGood}';
      case 'feelingNormal': return '😐 ${t.feelingNormal}';
      case 'feelingTired':  return '😔 ${t.feelingTired}';
      default:              return key;
    }
  }

  IconData _typeIcon(String key) {
    switch (key) {
      case 'donationWholeBlood': return Icons.bloodtype;
      case 'donationPlasma':     return Icons.opacity;
      case 'donationPlatelets':  return Icons.healing;
      default:                   return Icons.bloodtype;
    }
  }
}

// ─── Detail Card ──────────────────────────────────────────────────────────────

class _DetailCard extends StatelessWidget {
  final List<Widget> children;
  const _DetailCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: children
              .expand((w) => [w, const Divider(height: 1, indent: 56)])
              .toList()
            ..removeLast(), // прибираємо останній divider
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
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}