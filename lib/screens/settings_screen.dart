import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Locale) onLocaleChanged;

  const SettingsScreen({super.key, required this.onLocaleChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        .firstWhere((e) => e.value.languageCode == currentLocale.languageCode)
        .key;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

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
                  .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedLanguage = val);
                  widget.onLocaleChanged(supportedLocales[val]!);
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
