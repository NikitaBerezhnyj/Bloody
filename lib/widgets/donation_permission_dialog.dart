import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class DonationPermissionDialog extends StatelessWidget {
  const DonationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.health_and_safety,
              size: 60,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              t.permissionDialogTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              t.permissionDialogDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(t.noButton),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(t.yesButton),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
