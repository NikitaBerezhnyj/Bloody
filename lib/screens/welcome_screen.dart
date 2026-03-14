import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';
import '../providers/donations_provider.dart';
import '../services/backup_service.dart';
import '../l10n/app_localizations.dart';
import '../widgets/common/button.dart';
import 'create_profile_screen.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    ref.listen(userProvider, (_, next) {
      next.whenData((user) {
        if (user != null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const Spacer(flex: 2),

            const Icon(Icons.opacity, color: Colors.red, size: 72),
            const SizedBox(height: 16),
            Text(
              'Bloody',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.welcomeSubtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const Spacer(flex: 2),

            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: t.createProfile,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateProfileScreen(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlineButton(
                onPressed: () => _restoreFromBackup(context, ref, t),
                label: t.restoreFromBackup,
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> _restoreFromBackup(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations t,
  ) async {
    final success = await BackupService.importBackup();
    if (!context.mounted) return;

    if (success) {
      ref.invalidate(userProvider);
      ref.invalidate(donationsProvider);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.importError)));
    }
  }
}
