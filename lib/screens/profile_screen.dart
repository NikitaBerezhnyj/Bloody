import 'package:bloody/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../providers/donations_provider.dart';
import '../providers/user_provider.dart';
import '../services/database_service.dart';
import '../services/user_service.dart';
import '../services/widget_prompt_service.dart';
import '../services/widget_service.dart';
import '../widgets/common/header.dart';
import '../widgets/profile/profile_form.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('${t.error}: $e'))),
      data: (user) {
        if (user == null) {
          Future.microtask(() => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
          ));
          return const SizedBox.shrink();
        }
        return Scaffold(
          appBar: AppHeader(title: t.profileTitle, showBackButton: true),
          body: ProfileForm(
            initialUser: user,
            showLogoutButton: true,
            onSave: (updatedUser) async {
              await UserService.saveUser(updatedUser);
              ref.invalidate(userProvider);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.profileUpdated)));
            },
            onLogout: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(t.logoutConfirmTitle),
                  content: Text(t.logoutConfirmContent),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: Text(t.logout, style: const TextStyle(color: Colors.red))),
                  ],
                ),
              );
              if (confirm != true) return;

              final db = await DatabaseService.getDatabase();
              await db.delete('users');
              await db.delete('donations');
              await WidgetPromptService.cleanShown();

              final prefs = await SharedPreferences.getInstance();
              final locale = prefs.getString('locale') ?? 'uk';

              await WidgetService.updateWidget(
                donations: [],
                locale: locale,
              );

              ref.invalidate(userProvider);
              ref.invalidate(donationsProvider);
            },
            fixedButtonAtBottom: false,
          ),
        );
      },
    );
  }
}