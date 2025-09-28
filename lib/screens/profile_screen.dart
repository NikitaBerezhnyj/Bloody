import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'login_screen.dart';
import '../services/database_service.dart';
import '../l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  final Function(Locale) onLocaleChanged;
  const ProfileScreen({super.key, required this.onLocaleChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  User? _user;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
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
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await UserService.getUser();
    final t = AppLocalizations.of(context)!;

    genderMap = {"male": t.male, "female": t.female};

    if (user != null) {
      setState(() {
        _user = user;
        _nameController.text = user.name;
        _ageController.text = user.age.toString();
        _genderKey = user.gender;
        _bloodType = user.bloodType;
      });
    }
  }

  Future<void> _saveUser() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedUser = User(
      id: _user?.id,
      name: _nameController.text,
      age: int.parse(_ageController.text),
      gender: _genderKey!,
      bloodType: _bloodType!,
    );

    await UserService.saveUser(updatedUser);

    final t = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(t.profileUpdated)));

    setState(() {
      _user = updatedUser;
    });
  }

  Future<void> _logout() async {
    final t = AppLocalizations.of(context)!;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.logoutConfirmTitle),
        content: Text(t.logoutConfirmContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.logout, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final db = await DatabaseService.getDatabase();
      await db.delete('users');
      await db.delete('donations');

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(onLocaleChanged: widget.onLocaleChanged),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    if (_user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(t.profileTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: t.nameLabel),
                validator: (value) =>
                    value == null || value.isEmpty ? t.enterName : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: t.ageLabel),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return t.enterAge;
                  final age = int.tryParse(value);
                  if (age == null || age < 18) return t.ageMin18;
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _genderKey,
                decoration: InputDecoration(labelText: t.genderLabel),
                items: genderMap.entries
                    .map(
                      (e) =>
                          DropdownMenuItem(value: e.key, child: Text(e.value)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _genderKey = val),
                validator: (value) => value == null ? t.selectGender : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _bloodType,
                decoration: InputDecoration(labelText: t.bloodTypeLabel),
                items: bloodTypes
                    .map((bt) => DropdownMenuItem(value: bt, child: Text(bt)))
                    .toList(),
                onChanged: (val) => setState(() => _bloodType = val),
                validator: (value) => value == null ? t.selectBloodType : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _saveUser, child: Text(t.saveChanges)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(t.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
