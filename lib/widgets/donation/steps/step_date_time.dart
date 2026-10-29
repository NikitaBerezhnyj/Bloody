import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/date_formatters.dart';
import '../picker_tile.dart';
import '../step_wrapper.dart';

class StepDateTime extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const StepDateTime({
    super.key,
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
                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
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