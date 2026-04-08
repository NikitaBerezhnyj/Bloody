import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../models/user.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/profile_validator.dart';
import '../../widgets/common/button.dart';
import '../../utils/date_formatters.dart';

class ProfileForm extends StatefulWidget {
  final User? initialUser;
  final Future<void> Function(User updatedUser) onSave;
  final bool showLogoutButton;
  final VoidCallback? onLogout;
  final bool fixedButtonAtBottom;

  const ProfileForm({
    super.key,
    this.initialUser,
    required this.onSave,
    this.showLogoutButton = false,
    this.onLogout,
    this.fixedButtonAtBottom = false,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  DateTime? _birthday;
  String? _genderKey;
  String? _bloodType;
  bool _autoValidate = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    if (widget.initialUser != null) _initFromUser(widget.initialUser!);
  }

  void _initFromUser(User user) {
    if (_initialized) return;
    _nameController.text = user.name;
    _birthday = user.birthday;
    _genderKey = user.gender;
    _bloodType = user.bloodType;
    _initialized = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthday(BuildContext context, AppLocalizations t) async {
    final now = DateTime.now();
    final initialDate = _birthday ?? DateTime(now.year - 18, now.month, now.day);
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final lastDate = now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      setState(() => _birthday = picked);
      if (_autoValidate) _formKey.currentState?.validate();
    }
  }

  void _save(AppLocalizations t) {
    setState(() {
      _autoValidate = true;
    });

    if (!_formKey.currentState!.validate() || _birthday == null || _genderKey == null || _bloodType == null) return;

    final user = User(
      id: widget.initialUser?.id,
      name: _nameController.text.trim(),
      birthday: _birthday!,
      gender: _genderKey!,
      bloodType: _bloodType!,
    );
    widget.onSave(user);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final genderMap = {"male": t.male, "female": t.female};

    final formFields = <Widget>[
      TextFormField(
        controller: _nameController,
        decoration: InputDecoration(labelText: t.nameLabel),
        validator: (v) => validateName(v, t.nameError),
        onChanged: (_) {
          if (_autoValidate) _formKey.currentState?.validate();
        },
      ),
      const SizedBox(height: 12),
      GestureDetector(
        onTap: () => _pickBirthday(context, t),
        child: AbsorbPointer(
          child: TextFormField(
            controller: TextEditingController(
                text: _birthday != null ? formatDate(_birthday!) : ''),
            decoration: InputDecoration(
              labelText: t.birthdayLabel,
              hintText: t.birthdayError,
            ),
            validator: (_) =>
                validateBirthday(_birthday, t.birthdayError, t.birthdayValidation),
          ),
        ),
      ),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        value: _genderKey,
        decoration: InputDecoration(labelText: t.genderLabel),
        items: genderMap.entries
            .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
            .toList(),
        onChanged: (val) => setState(() => _genderKey = val),
        validator: (v) => validateRequired(v, t.genderError),
      ),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        value: _bloodType,
        decoration: InputDecoration(labelText: t.bloodTypeLabel),
        items: bloodTypes
            .map((bt) => DropdownMenuItem(value: bt, child: Text(bt)))
            .toList(),
        onChanged: (val) => setState(() => _bloodType = val),
        validator: (v) => validateRequired(v, t.bloodTypeError),
      ),
    ];

    final buttons = <Widget>[
      SizedBox(
        width: double.infinity,
        child: PrimaryButton(label: t.save, onPressed: () => _save(t)),
      ),
      if (widget.showLogoutButton && widget.onLogout != null) ...[
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlineButton(
            label: t.logout,
            onPressed: widget.onLogout,
          ),
        ),
      ],
    ];

    if (widget.fixedButtonAtBottom) {
      return Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: formFields,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: buttons),
          ),
        ],
      );
    } else {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...formFields,
                const SizedBox(height: 24),
                ...buttons,
              ],
            ),
          ),
        ),
      );
    }
  }
}