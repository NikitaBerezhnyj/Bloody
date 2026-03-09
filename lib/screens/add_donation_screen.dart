import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donation.dart';
import '../providers/donations_provider.dart';
import 'journal_screen.dart';
import '../l10n/app_localizations.dart';

class AddDonationScreen extends ConsumerStatefulWidget {
  final Donation? existing;
  const AddDonationScreen({super.key, this.existing});

  @override
  ConsumerState<AddDonationScreen> createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends ConsumerState<AddDonationScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedTypeKey;
  String? _selectedFeelingKey;
  final TextEditingController _notesController = TextEditingController();

  final List<String> donationTypeKeys = [
    "donationWholeBlood",
    "donationPlasma",
    "donationPlatelets",
  ];
  final List<String> feelingKeys = [
    "feelingGood",
    "feelingNormal",
    "feelingTired",
  ];

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _selectedDate     = e.date;
      _selectedTime     = e.time;
      _selectedTypeKey  = e.type;
      _selectedFeelingKey = e.feeling;
      _notesController.text = e.notes;
    }
  }

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

      final isEditing = widget.existing != null;

      final donation = Donation(
        id: widget.existing?.id,
        date: _selectedDate!,
        time: _selectedTime!,
        type: _selectedTypeKey!,
        feeling: _selectedFeelingKey!,
        notes: _notesController.text,
      );

      if (isEditing) {
        await ref.read(donationsProvider.notifier).edit(donation);
      } else {
        await ref.read(donationsProvider.notifier).add(donation);
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const JournalScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.fillAllFields)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing != null ? t.editDonation : t.addDonation),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(t.date),
                subtitle: Text(
                  _selectedDate != null
                      ? "${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}"
                      : t.selectDate,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Час донації"),
                subtitle: Text(
                  _selectedTime != null
                      ? "${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}"
                      : "Оберіть час",
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: _pickTime,
                ),
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedTypeKey,
                decoration: InputDecoration(labelText: t.donationType),
                items: donationTypeKeys.map((key) {
                  return DropdownMenuItem(
                    value: key,
                    child: Text(_translateDonationType(t, key)),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedTypeKey = val),
                validator: (value) =>
                    value == null ? t.selectDonationType : null,
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedFeelingKey,
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
              ),
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
