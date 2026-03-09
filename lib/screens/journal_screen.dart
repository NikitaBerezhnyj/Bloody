// journal_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../providers/donations_provider.dart';
import 'add_donation_screen.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  String _formatDate(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}";

  String _formatTime(TimeOfDay t) =>
      "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  String _translateType(AppLocalizations t, String key) {
    switch (key) {
      case "donationWholeBlood": return t.donationWholeBlood;
      case "donationPlasma":     return t.donationPlasma;
      case "donationPlatelets":  return t.donationPlatelets;
      default:                   return key;
    }
  }

  String _translateFeeling(AppLocalizations t, String key) {
    switch (key) {
      case "feelingGood":   return "😃 ${t.feelingGood}";
      case "feelingNormal": return "😐 ${t.feelingNormal}";
      case "feelingTired":  return "😔 ${t.feelingTired}";
      default:              return key;
    }
  }

  Icon _icon(String key) {
    switch (key) {
      case "donationWholeBlood": return const Icon(Icons.bloodtype, color: Colors.red, size: 36);
      case "donationPlasma":     return const Icon(Icons.opacity,   color: Colors.red, size: 36);
      case "donationPlatelets":  return const Icon(Icons.healing,   color: Colors.red, size: 36);
      default:                   return const Icon(Icons.bloodtype, color: Colors.red);
    }
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Видалити донацію?"),
        content: const Text("Цю дію неможливо скасувати."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Скасувати"),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Видалити"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final donationsAsync = ref.watch(donationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.journalTitle)),
      body: donationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Помилка: $e')),
        data: (donations) => donations.isEmpty
            ? Center(child: Text(t.noDonations))
            : ListView.builder(
          itemCount: donations.length,
          itemBuilder: (context, i) {
            final d = donations[i];
            return Dismissible(
              key: ValueKey(d.id),
              direction: DismissDirection.endToStart,
              // підтвердження перед видаленням
              confirmDismiss: (_) => _confirmDelete(context),
              onDismissed: (_) {
                ref.read(donationsProvider.notifier).delete(d.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Донацію видалено")),
                );
              },
              // червоний фон при свайпі
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: const Icon(Icons.delete, color: Colors.white, size: 28),
              ),
              child: Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  leading: _icon(d.type),
                  title: Text(
                    "${_translateType(t, d.type)} — ${_formatDate(d.date)} ${_formatTime(d.time)}",
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (d.feeling.isNotEmpty)
                        Text("${t.feeling}: ${_translateFeeling(t, d.feeling)}"),
                      if (d.notes.isNotEmpty)
                        Text("${t.notes}: ${d.notes}"),
                    ],
                  ),
                  // кнопка редагування
                  trailing: IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddDonationScreen(existing: d),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}