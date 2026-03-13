import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';
import '../providers/donations_provider.dart';
import '../services/backup_service.dart';
import '../l10n/app_localizations.dart';
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

            // Логотип
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
              t.welcomeSubtitle, // "Відстежуй свої донації крові"
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(flex: 2),

            // Кнопка створення профілю
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateProfileScreen()),
                ),
                child: Text(t.createProfile), // "Створити профіль"
              ),
            ),

            const SizedBox(height: 12),

            // Кнопка відновлення з backup
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _restoreFromBackup(context, ref, t),
                child: Text(
                  t.restoreFromBackup, // "Відновити з резервної копії"
                  style: const TextStyle(color: Colors.red),
                ),
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
      // userProvider тепер != null — InitialScreen сам переключиться на HomeScreen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.importError)),
      );
    }
  }
}