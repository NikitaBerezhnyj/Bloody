import 'package:bloody/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../l10n/app_localizations.dart';
import '../providers/donations_provider.dart';
import '../providers/user_provider.dart';
import '../services/database_service.dart';
import '../services/widget_prompt_service.dart';
import '../services/widget_service.dart';
import '../utils/date_formatters.dart';
import '../widgets/common/button.dart';
import '../widgets/common/detail_row.dart';
import '../widgets/common/header.dart';
import '../widgets/donation/detail_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('${t.error}: $e'))),
      data: (user) {
        if (user == null) {
          Future.microtask(() {
            if (!context.mounted) return;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const WelcomeScreen()),
              (route) => false,
            );
          });
          return const SizedBox.shrink();
        }

        return Scaffold(
          appBar: AppHeader(
            title: t.profileTitle,
            showBackButton: true,
            action: IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfileScreen(user: user),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    user.bloodType,
                    style: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user.name,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                DetailCard(
                  children: [
                    DetailRow(
                      icon: Icons.cake_outlined,
                      label: t.birthdayLabel,
                      value: formatDate(user.birthday),
                    ),
                    DetailRow(
                      icon: Icons.person_outline,
                      label: t.genderLabel,
                      value: user.gender == 'male' ? t.male : t.female,
                    ),
                    DetailRow(
                      icon: Icons.bloodtype_outlined,
                      label: t.bloodTypeLabel,
                      value: bloodTypeLabel(user.bloodType),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: OutlineButton(
              label: t.logout,
              onPressed: () => _confirmAndLogout(context, ref),
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmAndLogout(BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.logoutConfirmTitle),
        content: Text(t.logoutConfirmContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.logout, style: TextStyle(color: colorScheme.primary)),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    final db = await DatabaseService.getDatabase();
    await db.delete('users');
    await db.delete('donations');
    await WidgetPromptService.cleanShown();

    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString('locale') ?? 'en';

    await WidgetService.updateWidget(donations: [], locale: locale);

    ref.invalidate(userProvider);
    ref.invalidate(donationsProvider);
  }
}
