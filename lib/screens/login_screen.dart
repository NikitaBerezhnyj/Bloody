import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';
import '../l10n/app_localizations.dart';
import 'settings_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();

  DateTime? _birthday;
  String? _genderKey;
  String? _bloodType;
  late Map<String, String> genderMap;

  final List<String> bloodTypes = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "0+",
    "0-",
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final t = AppLocalizations.of(context)!;
    genderMap = {"male": t.male, "female": t.female};
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  void _pickBirthday() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime(now.year - 18),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _birthday = picked;
        _birthdayController.text =
            "${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}";
      });
    }
  }

  void _saveUser() async {
    if (!_formKey.currentState!.validate()) return;

    final user = User(
      name: _nameController.text,
      birthday: _birthday!,
      gender: _genderKey!,
      bloodType: _bloodType!,
    );

    await UserService.saveUser(user);

    ref.invalidate(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.opacity, color: Colors.red, size: 36),
            SizedBox(width: 8),
            Text("Bloody"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: t.profile,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
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
                    validator: (v) =>
                        v == null || v.isEmpty ? t.enterName : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _birthdayController,
                    readOnly: true,
                    decoration: InputDecoration(labelText: t.birthdayLabel),
                    onTap: _pickBirthday,
                    validator: (_) {
                      if (_birthday == null) return t.enterBirthday;
                      final now = DateTime.now();
                      final age =
                          now.year -
                          _birthday!.year -
                          ((now.month < _birthday!.month ||
                                  (now.month == _birthday!.month &&
                                      now.day < _birthday!.day))
                              ? 1
                              : 0);
                      return age < 18 ? t.ageValidation : null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: t.gender),
                    items: genderMap.entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(e.value),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => _genderKey = val),
                    validator: (v) => v == null ? t.selectGender : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: t.bloodType),
                    items: bloodTypes
                        .map(
                          (bt) => DropdownMenuItem(value: bt, child: Text(bt)),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => _bloodType = val),
                    validator: (v) => v == null ? t.selectBloodType : null,
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
