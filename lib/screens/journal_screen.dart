import 'package:bloody/utils/donation_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../providers/donations_provider.dart';
import '../utils/donation_labels.dart';
import '../widgets/common/header.dart';
import 'add_donation_screen.dart';
import 'donation_detail_screen.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

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
      appBar: AppHeader(
        title: t.journalTitle,
        showBackButton: true,
      ),
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

                    confirmDismiss: (_) => _confirmDelete(context),
                    onDismissed: (_) {
                      ref.read(donationsProvider.notifier).delete(d.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Донацію видалено")),
                      );
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DonationDetailScreen(donationId: d.id!),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        leading: Icon(typeIcon((d.type)), color: Colors.red, size: 36),
                        title: Text(
                          "${typeLabel(t, d.type)} — ${formatDate(d.date)} ${formatTime(d.time)}",
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (d.feeling.isNotEmpty)
                              Text(
                                "${t.feeling}: ${feelingLabelWithEmoji(t, d.feeling)}",
                              ),
                            if (d.notes.isNotEmpty)
                              Text("${t.notes}: ${d.notes}"),
                          ],
                        ),
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
