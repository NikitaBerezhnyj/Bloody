import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'home_screen.dart';
import '../l10n/app_localizations.dart';
import 'settings_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function(Locale) onLocaleChanged;
  const LoginScreen({super.key, required this.onLocaleChanged});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _genderKey;
  String? _bloodType;

  late Map<String, String> genderMap;
  late final List<String> bloodTypes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final t = AppLocalizations.of(context)!;

    genderMap = {
      "male": t.male,
      "female": t.female,
    };

    bloodTypes = ["A+", "A-", "B+", "B-", "AB+", "AB-", "0+", "0-"];
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        gender: _genderKey!,
        bloodType: _bloodType!,
      );
      await UserService.saveUser(user);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            onLocaleChanged: widget.onLocaleChanged,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.opacity, color: Colors.red, size: 36),
            const SizedBox(width: 8),
            const Text("Bloody"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: t.profile,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(
                    onLocaleChanged: widget.onLocaleChanged,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.fillProfile,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: t.name),
                    validator: (value) =>
                    value == null || value.isEmpty ? t.enterName : null,
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: t.age),
                    validator: (value) {
                      if (value == null || value.isEmpty) return t.enterAge;
                      final age = int.tryParse(value);
                      if (age == null || age < 18) return t.ageValidation;
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: t.gender),
                    items: genderMap.entries
                        .map((e) =>
                        DropdownMenuItem(value: e.key, child: Text(e.value)))
                        .toList(),
                    onChanged: (val) => setState(() => _genderKey = val),
                    validator: (value) =>
                    value == null ? t.selectGender : null,
                  ),

                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: t.bloodType),
                    items: bloodTypes
                        .map((bt) => DropdownMenuItem(value: bt, child: Text(bt)))
                        .toList(),
                    onChanged: (val) => setState(() => _bloodType = val),
                    validator: (value) =>
                    value == null ? t.selectBloodType : null,
                  ),

                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveUser,
                        child: Text(t.save),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
