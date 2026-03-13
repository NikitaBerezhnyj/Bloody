import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donation.dart';
import '../providers/donations_provider.dart';
import '../l10n/app_localizations.dart';
import 'journal_screen.dart';
import 'thank_you_screen.dart';

class AddDonationScreen extends ConsumerStatefulWidget {
  final Donation? existing;
  const AddDonationScreen({super.key, this.existing});

  @override
  ConsumerState<AddDonationScreen> createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends ConsumerState<AddDonationScreen> {
  int _currentStep = 0;
  static const int _totalSteps = 5;

  // Стан всіх кроків
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
      _selectedDate       = e.date;
      _selectedTime       = e.time;
      _selectedTypeKey    = e.type;
      _selectedFeelingKey = e.feeling;
      _notesController.text = e.notes;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  // ─── Навігація між кроками ────────────────────────────────────────────────

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
          _showError(t.fillAllFields);
          return false;
        }
      case 1:
        if (_selectedTypeKey == null) {
          _showError(t.selectDonationType);
          return false;
        }
      case 2:
        if (_selectedFeelingKey == null) {
          _showError(t.selectFeeling);
          return false;
        }
    }
    return true;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ─── Збереження ──────────────────────────────────────────────────────────

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const JournalScreen()),
      );
    } else {
      await ref.read(donationsProvider.notifier).add(donation);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ThankYouScreen()),
      );
    }
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing != null ? t.editDonation : t.addDonation),
      ),
      body: Column(
        children: [
          _ProgressBar(current: _currentStep, total: _totalSteps),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey(_currentStep),
                child: _buildStep(t),
              ),
            ),
          ),
          _NavigationButtons(
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

// ─── Progress Bar ─────────────────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final int current;
  final int total;

  const _ProgressBar({
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (current + 1) / total,
              minHeight: 6,
              backgroundColor: Colors.red.shade100,
              valueColor: const AlwaysStoppedAnimation(Colors.red),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${AppLocalizations.of(context)!.step} ${current + 1} / $total',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

// ─── Navigation Buttons ───────────────────────────────────────────────────────

class _NavigationButtons extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final VoidCallback? onSave;

  const _NavigationButtons({
    required this.currentStep,
    required this.totalSteps,
    this.onNext,
    this.onBack,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isLast = currentStep == totalSteps - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Row(
        children: [
          if (onBack != null)
            Expanded(
              child: OutlinedButton(
                onPressed: onBack,
                child: Text(t.back), // "Назад"
              ),
            ),
          if (onBack != null) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: isLast ? onSave : onNext,
              child: Text(isLast ? t.saveDonation : t.next), // "Зберегти" / "Далі"
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Step 1: Date & Time ──────────────────────────────────────────────────────

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

    return _StepWrapper(
      title: t.date,
      child: Column(
        children: [
          _PickerTile(
            icon: Icons.calendar_today,
            label: t.date,
            value: selectedDate != null
                ? "${selectedDate!.day.toString().padLeft(2, '0')}.${selectedDate!.month.toString().padLeft(2, '0')}.${selectedDate!.year}"
                : t.selectDate,
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
          _PickerTile(
            icon: Icons.access_time,
            label: t.donationTime, // "Час донації"
            value: selectedTime != null
                ? "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                : t.selectTime, // "Оберіть час"
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
              if (picked != null) onTimeChanged(picked);
            },
          ),
        ],
      ),
    );
  }
}

// ─── Step 2: Donation Type ────────────────────────────────────────────────────

class _StepDonationType extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onChanged;

  const _StepDonationType({required this.selected, required this.onChanged});

  static const _types = ['donationWholeBlood', 'donationPlasma', 'donationPlatelets'];
  static const _icons = [Icons.bloodtype, Icons.opacity, Icons.healing];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    String label(String key) {
      switch (key) {
        case 'donationWholeBlood': return t.donationWholeBlood;
        case 'donationPlasma':     return t.donationPlasma;
        case 'donationPlatelets':  return t.donationPlatelets;
        default: return key;
      }
    }

    return _StepWrapper(
      title: t.donationType,
      child: Column(
        children: List.generate(_types.length, (i) {
          final key = _types[i];
          final isSelected = selected == key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SelectionCard(
              icon: _icons[i],
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

// ─── Step 3: Feeling ──────────────────────────────────────────────────────────

class _StepFeeling extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onChanged;

  const _StepFeeling({required this.selected, required this.onChanged});

  static const _feelings = ['feelingGood', 'feelingNormal', 'feelingTired'];
  static const _emojis   = ['😃', '😐', '😔'];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    String label(String key) {
      switch (key) {
        case 'feelingGood':   return t.feelingGood;
        case 'feelingNormal': return t.feelingNormal;
        case 'feelingTired':  return t.feelingTired;
        default: return key;
      }
    }

    return _StepWrapper(
      title: t.feeling,
      child: Column(
        children: List.generate(_feelings.length, (i) {
          final key = _feelings[i];
          final isSelected = selected == key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SelectionCard(
              emoji: _emojis[i],
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

// ─── Step 4: Notes ────────────────────────────────────────────────────────────

class _StepNotes extends StatelessWidget {
  final TextEditingController controller;
  const _StepNotes({required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return _StepWrapper(
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

// ─── Step 5: Confirmation ─────────────────────────────────────────────────────

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

    String typeName() {
      switch (typeKey) {
        case 'donationWholeBlood': return t.donationWholeBlood;
        case 'donationPlasma':     return t.donationPlasma;
        case 'donationPlatelets':  return t.donationPlatelets;
        default: return typeKey;
      }
    }

    String feelingName() {
      switch (feelingKey) {
        case 'feelingGood':   return '😃 ${t.feelingGood}';
        case 'feelingNormal': return '😐 ${t.feelingNormal}';
        case 'feelingTired':  return '😔 ${t.feelingTired}';
        default: return feelingKey;
      }
    }

    final dateStr = "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
    final timeStr = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

    return _StepWrapper(
      title: t.confirmation, // "Підтвердження"
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _ConfirmRow(label: t.date, value: dateStr),
              _ConfirmRow(label: t.time, value: timeStr),
              _ConfirmRow(label: t.donationType, value: typeName()),
              _ConfirmRow(label: t.feeling,      value: feelingName()),
              if (notes.isNotEmpty)
                _ConfirmRow(label: t.notes,      value: notes),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final String label;
  final String value;
  const _ConfirmRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

// ─── Reusable widgets ─────────────────────────────────────────────────────────

class _StepWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  const _StepWrapper({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  const _PickerTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.red),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionCard({
    this.icon,
    this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.shade50 : null,
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, color: isSelected ? Colors.red : Colors.grey),
            if (emoji != null)
              Text(emoji!, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.red : null,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.red, size: 20),
          ],
        ),
      ),
    );
  }
}