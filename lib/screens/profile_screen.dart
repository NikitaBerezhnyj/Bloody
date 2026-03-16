import 'package:bloody/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../models/user.dart';
import '../providers/donations_provider.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';
import '../services/database_service.dart';
import '../l10n/app_localizations.dart';
import '../services/widget_prompt_service.dart';
import '../utils/profile_validator.dart';
import '../widgets/common/button.dart';
import '../widgets/common/header.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  DateTime? _birthday;
  String? _genderKey;
  String? _bloodType;

  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _initFromUser(User user) {
    if (_initialized) return;
    _nameController.text = user.name;
    _birthday = user.birthday;
    _genderKey = user.gender;
    _bloodType = user.bloodType;
    _initialized = true;
  }

  Future<void> _pickBirthday() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime(now.year - 18),
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year - 18),
    );
    if (picked != null) setState(() => _birthday = picked);
  }

  Future<void> _saveUser(User? currentUser) async {
    final t = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_birthday == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.birthdayError)));
      return;
    }

    final updatedUser = User(
      id: currentUser?.id,
      name: _nameController.text,
      birthday: _birthday!,
      gender: _genderKey!,
      bloodType: _bloodType!,
    );

    await UserService.saveUser(updatedUser);

    ref.invalidate(userProvider);

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(t.profileUpdated)));
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

    if (confirm != true) return;

    final db = await DatabaseService.getDatabase();
    await db.delete('users');
    await db.delete('donations');
    await WidgetPromptService.cleanShown();

    ref.invalidate(userProvider);
    ref.invalidate(donationsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final userAsync = ref.watch(userProvider);
    final genderMap = {"male": t.male, "female": t.female};

    ref.listen(userProvider, (_, next) {
      next.whenData((user) {
        if (user == null && mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
          );
        }
      });
    });

    return userAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('${t.error}: $e'))),
      data: (user) {
        if (user != null) _initFromUser(user);

        return Scaffold(
          appBar: AppHeader(
            title: t.profileTitle,
            showBackButton: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: t.nameLabel),
                      validator: (v) =>
                          v == null || v.isEmpty ? t.nameLabel : null,
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _pickBirthday,
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: t.birthdayLabel,
                            hintText: t.birthdayError,
                          ),
                          controller: TextEditingController(
                            text: _birthday != null
                                ? "${_birthday!.day.toString().padLeft(2, '0')}.${_birthday!.month.toString().padLeft(2, '0')}.${_birthday!.year}"
                                : '',
                          ),
                          validator: (_) {
                            if (_birthday == null) return t.birthdayError;

                            if (calculateAge(_birthday!) < 18) {
                              return t.birthdayValidation;
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _genderKey,
                      decoration: InputDecoration(labelText: t.genderLabel),
                      items: genderMap.entries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _genderKey = val),
                      validator: (v) => v == null ? t.genderError : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _bloodType,
                      decoration: InputDecoration(labelText: t.bloodTypeLabel),
                      items: bloodTypes
                          .map(
                            (bt) =>
                                DropdownMenuItem(value: bt, child: Text(bt)),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _bloodType = val),
                      validator: (v) => v == null ? t.bloodTypeError : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: t.save,
                        onPressed: () => _saveUser(user),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlineButton(
                        label: t.logout,
                        onPressed: _logout,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
