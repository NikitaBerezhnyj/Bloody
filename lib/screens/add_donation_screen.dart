import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../models/donation.dart';
import '../providers/donations_provider.dart';
import '../l10n/app_localizations.dart';
import '../services/donation_service.dart';
import '../utils/date_formatters.dart';
import '../widgets/common/header.dart';
import '../widgets/common/progress_bar.dart';
import '../widgets/donation/confirm_row.dart';
import '../widgets/donation/navigation_buttons.dart';
import '../widgets/donation/picker_tile.dart';
import '../widgets/donation/selection_card.dart';
import '../widgets/donation/step_wrapper.dart';
import 'thank_you_screen.dart';
import '../utils/donation_labels.dart';

class AddDonationScreen extends ConsumerStatefulWidget {
  final Donation? existing;
  const AddDonationScreen({super.key, this.existing});

  @override
  ConsumerState<AddDonationScreen> createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends ConsumerState<AddDonationScreen> {
  int _currentStep = 0;
  static const int _totalSteps = 5;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedTypeKey;
  String? _selectedFeelingKey;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _selectedDate = e.date;
      _selectedTime = e.time;
      _selectedTypeKey = e.type;
      _selectedFeelingKey = e.feeling;
      _notesController.text = e.notes;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (!_validateCurrentStep()) return;
    setState(() => _currentStep++);
  }

  void _prevStep() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  bool _validateCurrentStep() {
    final t = AppLocalizations.of(context)!;
    switch (_currentStep) {
      case 0:
        if (_selectedDate == null || _selectedTime == null) {
          _showError(t.dateError);
          return false;
        }
      case 1:
        if (_selectedTypeKey == null) {
          _showError(t.donationTypeError);
          return false;
        }
      case 2:
        if (_selectedFeelingKey == null) {
          _showError(t.feelingError);
          return false;
        }
    }
    return true;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _saveDonation() async {
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
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      await ref.read(donationsProvider.notifier).add(donation);
      final donations = await DonationService.getDonations();
      final newId = donations.isNotEmpty ? donations.first.id : null;
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ThankYouScreen(newDonationId: newId)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppHeader(
        title: widget.existing != null ? t.editDonation : t.addDonation,
        showBackButton: true,
      ),
      body: Column(
        children: [
          ProgressBar(current: _currentStep, total: _totalSteps),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey(_currentStep),
                child: _buildStep(t),
              ),
            ),
          ),
          NavigationButtons(
            currentStep: _currentStep,
            totalSteps: _totalSteps,
            onNext: _currentStep < _totalSteps - 1 ? _nextStep : null,
            onBack: _currentStep > 0 ? _prevStep : null,
            onSave: _currentStep == _totalSteps - 1 ? _saveDonation : null,
          ),
        ],
      ),
    );
  }

  Widget _buildStep(AppLocalizations t) {
    switch (_currentStep) {
      case 0:
        return _StepDateTime(
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          onDateChanged: (d) => setState(() => _selectedDate = d),
          onTimeChanged: (t) => setState(() => _selectedTime = t),
        );
      case 1:
        return _StepDonationType(
          selected: _selectedTypeKey,
          onChanged: (v) => setState(() => _selectedTypeKey = v),
        );
      case 2:
        return _StepFeeling(
          selected: _selectedFeelingKey,
          onChanged: (v) => setState(() => _selectedFeelingKey = v),
        );
      case 3:
        return _StepNotes(controller: _notesController);
      case 4:
        return _StepConfirmation(
          date: _selectedDate!,
          time: _selectedTime!,
          typeKey: _selectedTypeKey!,
          feelingKey: _selectedFeelingKey!,
          notes: _notesController.text,
        );
      default:
        return const SizedBox();
    }
  }
}

class _StepDateTime extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const _StepDateTime({
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return StepWrapper(
      title: t.date,
      child: Column(
        children: [
          PickerTile(
            icon: Icons.calendar_today,
            label: t.date,
            value: selectedDate != null ? formatDate(selectedDate!) : t.dateError,
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? now,
                firstDate: DateTime(now.year - 1),
                lastDate: now,
              );
              if (picked != null) onDateChanged(picked);
            },
          ),
          const SizedBox(height: 12),
          PickerTile(
            icon: Icons.access_time,
            label: t.time,
            value: selectedTime != null ? formatTime(selectedTime!) : t.timeError,
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      alwaysUse24HourFormat: true,
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) onTimeChanged(picked);
            },
          ),
        ],
      ),
    );
  }
}

class _StepDonationType extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onChanged;

  const _StepDonationType({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    String label(String key) {
      switch (key) {
        case 'donationWholeBlood':
          return t.donationWholeBlood;
        case 'donationPlasma':
          return t.donationPlasma;
        case 'donationPlatelets':
          return t.donationPlatelets;
        default:
          return key;
      }
    }

    return StepWrapper(
      title: t.donationType,
      child: Column(
        children: List.generate(donationTypes.length, (i) {
          final key = donationTypes[i];
          final isSelected = selected == key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SelectionCard(
              icon: typeIcon(key),
              label: label(key),
              isSelected: isSelected,
              onTap: () => onChanged(key),
            ),
          );
        }),
      ),
    );
  }
}

class _StepFeeling extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onChanged;

  const _StepFeeling({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return StepWrapper(
      title: t.feeling,
      child: Column(
        children: List.generate(feelingKeys.length, (i) {
          final key = feelingKeys[i];
          final isSelected = selected == key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SelectionCard(
              emoji: feelingEmoji(t, key),
              label: feelingLabel(t, key),
              isSelected: isSelected,
              onTap: () => onChanged(key),
            ),
          );
        }),
      ),
    );
  }
}

class _StepNotes extends StatelessWidget {
  final TextEditingController controller;
  const _StepNotes({required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return StepWrapper(
      title: t.notes,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: t.notesHint,
          border: const OutlineInputBorder(),
        ),
        maxLines: 5,
        autofocus: true,
      ),
    );
  }
}

class _StepConfirmation extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final String typeKey;
  final String feelingKey;
  final String notes;

  const _StepConfirmation({
    required this.date,
    required this.time,
    required this.typeKey,
    required this.feelingKey,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final dateStr =
        "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
    final timeStr =
        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

    return StepWrapper(
      title: t.confirmation,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ConfirmRow(label: t.date, value: dateStr),
              ConfirmRow(label: t.time, value: timeStr),
              ConfirmRow(
                label: t.donationType,
                value: typeLabel(t, typeKey),
              ),
              ConfirmRow(
                label: t.feeling,
                value: feelingLabelWithEmoji(t, feelingKey),
              ),
              if (notes.isNotEmpty) ConfirmRow(label: t.notes, value: notes),
            ],
          ),
        ),
      ),
    );
  }
}


