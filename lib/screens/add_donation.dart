import 'package:flutter/material.dart';
import '../models/donation.dart';
import '../services/donation_service.dart';
import 'journal_screen.dart';
import '../l10n/app_localizations.dart';

class AddDonationScreen extends StatefulWidget {
  const AddDonationScreen({super.key});

  @override
  State<AddDonationScreen> createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends State<AddDonationScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedTypeKey;
  String? _selectedFeelingKey;
  final TextEditingController _notesController = TextEditingController();

  final List<String> donationTypeKeys = ["donationWholeBlood", "donationPlasma", "donationPlatelets"];
  final List<String> feelingKeys = ["feelingGood", "feelingNormal", "feelingTired"];

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _pickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? now,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveDonation() async {
    final t = AppLocalizations.of(context)!;

    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null &&
        _selectedTypeKey != null &&
        _selectedFeelingKey != null) {

      final donation = Donation(
        date: _selectedDate!,
        time: _selectedTime!,
        type: _selectedTypeKey!,
        feeling: _selectedFeelingKey!,
        notes: _notesController.text,
      );

      await DonationService.addDonation(donation);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const JournalScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.fillAllFields)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(t.addDonation)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(t.date),
                subtitle: Text(_selectedDate != null
                    ? "${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}"
                    : t.selectDate),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Час донації"),
                subtitle: Text(_selectedTime != null
                    ? "${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}"
                    : "Оберіть час"),
                trailing: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: _pickTime,
                ),
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: t.donationType),
                items: donationTypeKeys.map((key) {
                  return DropdownMenuItem(
                    value: key,
                    child: Text(_translateDonationType(t, key)),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedTypeKey = val),
                validator: (value) => value == null ? t.selectDonationType : null,
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: t.feeling),
                items: feelingKeys.map((key) {
                  return DropdownMenuItem(
                    value: key,
                    child: Text(_translateFeeling(t, key)),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedFeelingKey = val),
                validator: (value) => value == null ? t.selectFeeling : null,
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: t.notes,
                  hintText: t.notesHint,
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveDonation,
                child: Text(t.saveDonation),
              )
            ],
          ),
        ),
      ),
    );
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
}