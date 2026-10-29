import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../models/donation.dart';
import '../providers/donations_provider.dart';
import '../widgets/common/button.dart';
import '../widgets/common/header.dart';
import '../widgets/donation/steps/step_date_time.dart';
import '../widgets/donation/steps/step_donation_type.dart';
import '../widgets/donation/steps/step_feeling.dart';
import '../widgets/donation/steps/step_notes.dart';
import '../widgets/donation/steps/step_confirmation.dart';
import 'changes_saved_screen.dart';

class EditDonationScreen extends ConsumerStatefulWidget {
  final Donation donation;

  const EditDonationScreen({super.key, required this.donation});

  @override
  ConsumerState<EditDonationScreen> createState() => _EditDonationScreenState();
}

class _EditDonationScreenState extends ConsumerState<EditDonationScreen> {
  int? _editingField;

  late DateTime _date;
  late TimeOfDay _time;
  late String _type;
  late String _feeling;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    final d = widget.donation;
    _date = d.date;
    _time = d.time;
    _type = d.type;
    _feeling = d.feeling;
    _notesController = TextEditingController(text: d.notes);
    _notesController.addListener(_onNotesChanged);
  }

  void _onNotesChanged() => setState(() {});

  @override
  void dispose() {
    _notesController.removeListener(_onNotesChanged);
    _notesController.dispose();
    super.dispose();
  }

  void _openField(int field) => setState(() => _editingField = field);
  void _backToConfirmation() => setState(() => _editingField = null);

  Future<void> _save() async {
    final updated = Donation(
      id: widget.donation.id,
      date: _date,
      time: _time,
      type: _type,
      feeling: _feeling,
      notes: _notesController.text,
    );

    await ref.read(donationsProvider.notifier).edit(updated);
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChangesSavedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final editing = _editingField != null;

    return Scaffold(
      appBar: AppHeader(
        title: editing ? _fieldTitle(t, _editingField!) : t.editDonation,
        showBackButton: true,
        // на кроці редагування поля "назад" веде до підтвердження,
        // а не одразу назовні з екрана
        onBack: editing ? _backToConfirmation : null,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(key: ValueKey(_editingField), child: _buildBody(t)),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: PrimaryButton(
          label: editing ? t.done : t.save,
          onPressed: editing ? _backToConfirmation : _save,
        ),
      ),
    );
  }

  String _fieldTitle(AppLocalizations t, int field) {
    switch (field) {
      case 0:
        return t.date;
      case 1:
        return t.donationType;
      case 2:
        return t.feeling;
      case 3:
        return t.notes;
      default:
        return t.editDonation;
    }
  }

  Widget _buildBody(AppLocalizations t) {
    switch (_editingField) {
      case 0:
        return StepDateTime(
          selectedDate: _date,
          selectedTime: _time,
          onDateChanged: (d) => setState(() => _date = d),
          onTimeChanged: (v) => setState(() => _time = v),
        );
      case 1:
        return StepDonationType(
          selected: _type,
          onChanged: (v) => setState(() => _type = v),
        );
      case 2:
        return StepFeeling(
          selected: _feeling,
          onChanged: (v) => setState(() => _feeling = v),
        );
      case 3:
        return StepNotes(controller: _notesController);
      default:
        return StepConfirmation(
          date: _date,
          time: _time,
          typeKey: _type,
          feelingKey: _feeling,
          notes: _notesController.text,
          onEditStep: _openField,
        );
    }
  }
}
