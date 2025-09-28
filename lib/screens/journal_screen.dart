import 'package:flutter/material.dart';
import '../models/donation.dart';
import '../services/donation_service.dart';
import '../l10n/app_localizations.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<Donation> _donations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDonations();
  }

  Future<void> _loadDonations() async {
    final donations = await DonationService.getDonations();
    setState(() {
      _donations = donations;
      _isLoading = false;
    });
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2,'0')}.${date.month.toString().padLeft(2,'0')}.${date.year}";
  }

  String _translateDonationType(AppLocalizations t, String key) {
    switch (key) {
      case "donationWholeBlood":
        return t.donationWholeBlood;
      case "donationPlasma":
        return t.donationPlasma;
      case "donationPlatelets":
        return t.donationPlatelets;
      default:
        return key;
    }
  }

  String _translateFeeling(AppLocalizations t, String key) {
    switch (key) {
      case "feelingGood":
        return "😃 ${t.feelingGood}";
      case "feelingNormal":
        return "😐 ${t.feelingNormal}";
      case "feelingTired":
        return "😔 ${t.feelingTired}";
      default:
        return key;
    }
  }

  Icon _getDonationIcon(String key) {
    switch (key) {
      case "donationWholeBlood":
        return const Icon(Icons.bloodtype, color: Colors.red, size: 36);
      case "donationPlasma":
        return const Icon(Icons.opacity, color: Colors.red, size: 36);
      case "donationPlatelets":
        return const Icon(Icons.healing, color: Colors.red, size: 36);
      default:
        return const Icon(Icons.bloodtype, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(t.journalTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _donations.isEmpty
          ? Center(child: Text(t.noDonations))
          : ListView.builder(
        itemCount: _donations.length,
        itemBuilder: (context, index) {
          final donation = _donations[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: _getDonationIcon(donation.type),
              title: Text("${_translateDonationType(t, donation.type)} — ${_formatDate(donation.date)}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (donation.feeling.isNotEmpty)
                    Text("${t.feeling}: ${_translateFeeling(t, donation.feeling)}"),
                  if (donation.notes.isNotEmpty)
                    Text("${t.notes}: ${donation.notes}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
