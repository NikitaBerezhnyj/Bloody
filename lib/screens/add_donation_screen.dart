import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../models/donation.dart';
import '../providers/donations_provider.dart';
import '../services/donation_service.dart';
import '../widgets/common/header.dart';
import '../widgets/common/progress_bar.dart';
import '../widgets/donation/navigation_buttons.dart';
import '../widgets/donation/steps/step_date_time.dart';
import '../widgets/donation/steps/step_donation_type.dart';
import '../widgets/donation/steps/step_feeling.dart';
import '../widgets/donation/steps/step_notes.dart';
import '../widgets/donation/steps/step_confirmation.dart';
import 'thank_you_screen.dart';

class AddDonationScreen extends ConsumerStatefulWidget {
  const AddDonationScreen({super.key});

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
    _notesController.addListener(_onNotesChanged);
  }

  void _onNotesChanged() => setState(() {});

  @override
  void dispose() {
    _notesController.removeListener(_onNotesChanged);
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

  String? _nextButtonLabel(AppLocalizations t) {
    if (_currentStep == 3 && _notesController.text.trim().isEmpty) {
      return t.skip;
    }
    return null;
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
    final donation = Donation(
      date: _selectedDate!,
      time: _selectedTime!,
      type: _selectedTypeKey!,
      feeling: _selectedFeelingKey!,
      notes: _notesController.text,
    );

    await ref.read(donationsProvider.notifier).add(donation);
    final donations = await DonationService.getDonations();
    final newId = donations.isNotEmpty ? donations.first.id : null;
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ThankYouScreen(newDonationId: newId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppHeader(title: t.addDonation, showBackButton: true),
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
            nextLabel: _nextButtonLabel(t),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(AppLocalizations t) {
    switch (_currentStep) {
      case 0:
        return StepDateTime(
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          onDateChanged: (d) => setState(() => _selectedDate = d),
          onTimeChanged: (v) => setState(() => _selectedTime = v),
        );
      case 1:
        return StepDonationType(
          selected: _selectedTypeKey,
          onChanged: (v) => setState(() => _selectedTypeKey = v),
        );
      case 2:
        return StepFeeling(
          selected: _selectedFeelingKey,
          onChanged: (v) => setState(() => _selectedFeelingKey = v),
        );
      case 3:
        return StepNotes(controller: _notesController);
      case 4:
        return StepConfirmation(
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
