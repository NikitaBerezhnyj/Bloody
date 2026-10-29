import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../step_wrapper.dart';

class StepNotes extends StatelessWidget {
  final TextEditingController controller;

  const StepNotes({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return StepWrapper(
      title: t.notesOptional,
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