import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';
import '../widgets/common/header.dart';
import '../widgets/profile/profile_form.dart';

class EditProfileScreen extends ConsumerWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppHeader(title: t.profileTitle, showBackButton: true),
      body: ProfileForm(
        initialUser: user,
        onSave: (updatedUser) async {
          await UserService.saveUser(updatedUser);
          ref.invalidate(userProvider);
          if (!context.mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.profileUpdated)));
          Navigator.pop(context);
        },
      ),
    );
  }
}
