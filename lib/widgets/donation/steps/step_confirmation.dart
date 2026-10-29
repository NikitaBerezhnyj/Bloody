import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/donation_labels.dart';
import '../confirm_row.dart';
import '../step_wrapper.dart';

class StepConfirmation extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final String typeKey;
  final String feelingKey;
  final String notes;
  final ValueChanged<int>? onEditStep; // null = create-режим, без тапів

  const StepConfirmation({
    super.key,
    required this.date,
    required this.time,
    required this.typeKey,
    required this.feelingKey,
    required this.notes,
    this.onEditStep,
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
              ConfirmRow(
                label: t.date,
                value: dateStr,
                onTap: onEditStep != null ? () => onEditStep!(0) : null,
              ),
              ConfirmRow(
                label: t.time,
                value: timeStr,
                onTap: onEditStep != null ? () => onEditStep!(0) : null,
              ),
              ConfirmRow(
                label: t.donationType,
                value: typeLabel(t, typeKey),
                onTap: onEditStep != null ? () => onEditStep!(1) : null,
              ),
              ConfirmRow(
                label: t.feeling,
                value: feelingLabel(t, feelingKey),
                onTap: onEditStep != null ? () => onEditStep!(2) : null,
              ),
              if (notes.isNotEmpty || onEditStep != null)
                ConfirmRow(
                  label: t.notes,
                  value: notes.isNotEmpty ? notes : t.notesEmpty,
                  onTap: onEditStep != null ? () => onEditStep!(3) : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
