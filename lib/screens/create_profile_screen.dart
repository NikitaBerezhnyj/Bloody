import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';
import '../widgets/common/header.dart';
import '../widgets/profile/profile_form.dart';
import 'home_screen.dart';

class CreateProfileScreen extends ConsumerWidget {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppHeader(title: t.createProfileTitle, showBackButton: true, showSettingsButton: true),
      body: ProfileForm(
        onSave: (user) async {
          await UserService.saveUser(user);
          ref.invalidate(userProvider);
          if (!context.mounted) return;
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
          );
        },
        fixedButtonAtBottom: true,
      ),
    );
  }
}