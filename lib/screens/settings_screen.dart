import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../providers/donations_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../services/backup_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? _selectedLanguage;

  final Map<String, Locale> supportedLocales = {
    "English": const Locale('en'),
    "Українська": const Locale('uk'),
    "Español": const Locale('es'),
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentLocale = Localizations.localeOf(context);
    _selectedLanguage = supportedLocales.entries
        .firstWhere(
          (e) => e.value.languageCode == currentLocale.languageCode,
          orElse: () => supportedLocales.entries.first,
        )
        .key;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final themeAsync = ref.watch(themeProvider);
    final selectedTheme = themeAsync.valueOrNull ?? ThemeMode.system;

    return Scaffold(
      appBar: AppBar(title: Text(t.settingsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.languageLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              items: supportedLocales.keys
                  .map(
                    (lang) => DropdownMenuItem(value: lang, child: Text(lang)),
                  )
                  .toList(),
              onChanged: (val) async {
                if (val == null) return;
                setState(() => _selectedLanguage = val);

                await ref
                    .read(localeProvider.notifier)
                    .setLocale(supportedLocales[val]!);
              },
            ),
            const SizedBox(height: 24),
            Text(
              t.themeLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ThemeMode>(
              value: selectedTheme,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(t.systemThemeLabel),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(t.lightThemeLabel),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(t.darkThemeLabel),
                ),
              ],
              onChanged: (mode) async {
                if (mode == null) return;

                await ref.read(themeProvider.notifier).setTheme(mode);
              },
            ),
            const SizedBox(height: 24),
            Text(
              t.backupLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.upload_file),
                    label: Text(t.exportBackup),
                    onPressed: () async {
                      try {
                        await BackupService.exportBackup(context);
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Помилка: $e')),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.download),
                    label: Text(t.importBackup),
                    onPressed: () async {
                      final success = await BackupService.importBackup();
                      if (!context.mounted) return;
                      if (success) {
                        ref.invalidate(userProvider);
                        ref.invalidate(donationsProvider);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.importSuccess)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.importError)),
                        );
                      }
                    },
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
