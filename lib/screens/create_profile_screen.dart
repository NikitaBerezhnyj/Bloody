import 'package:bloody/screens/widget_prompt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../utils/profile_validator.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';
import '../l10n/app_localizations.dart';
import '../services/widget_prompt_service.dart';
import '../widgets/common/button.dart';
import '../widgets/common/header.dart';
import 'home_screen.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  ConsumerState<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();

  DateTime? _birthday;
  String? _genderKey;
  String? _bloodType;
  late Map<String, String> genderMap;

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

    ref.listen<AsyncValue<User?>>(userProvider, (_, next) {
      next.whenData((user) {
        if (user != null && mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!mounted) return;

            final shouldShow = await WidgetPromptService.shouldShow();
            if (shouldShow) {
              await WidgetPromptService.markShown();

              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WidgetPromptScreen()),
              );
            }

            if (mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
              );
            }
          });
        }
      });
    });

    return Scaffold(
      appBar: AppHeader(
        title: t.createProfileTitle,
        showBackButton: true,
        showSettingsButton: true,
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
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: t.nameLabel),
                    validator: (v) =>
                        v == null || v.isEmpty ? t.nameError : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _birthdayController,
                    readOnly: true,
                    decoration: InputDecoration(labelText: t.birthdayLabel),
                    onTap: _pickBirthday,
                    validator: (_) {
                      if (_birthday == null) return t.birthdayError;

                      if (calculateAge(_birthday!) < 18) {
                        return t.birthdayValidation;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
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
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: t.bloodTypeLabel),
                    items: bloodTypes
                        .map(
                          (bt) => DropdownMenuItem(value: bt, child: Text(bt)),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => _bloodType = val),
                    validator: (v) => v == null ? t.bloodTypeError : null,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: PrimaryButton(
                      label: t.save,
                      onPressed: _saveUser,
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
