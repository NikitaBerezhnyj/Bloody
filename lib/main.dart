import 'package:bloody/providers/locale_provider.dart';
import 'package:bloody/providers/theme_provider.dart';
import 'package:bloody/screens/splash_screen.dart';
import 'package:bloody/screens/welcome_screen.dart';
import 'package:bloody/services/donation_service.dart';
import 'package:bloody/services/notification_service.dart';
import 'package:bloody/services/widget_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloody/l10n/app_localizations.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';

@pragma('vm:entry-point')
Future<void> widgetBackgroundCallback(Uri? uri) async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeWidget.setAppGroupId('com.nikitaberezhnyj.bloody');
  final donations = await DonationService.getDonations();
  final prefs = await SharedPreferences.getInstance();
  final locale = prefs.getString('locale') ?? 'en';
  await WidgetService.updateWidget(donations: donations, locale: locale);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(widgetBackgroundCallback);

  await NotificationService.init();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: BloodyApp()));
}

class BloodyApp extends ConsumerWidget {
  const BloodyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeAsync = ref.watch(localeProvider);
    final themeAsync = ref.watch(themeProvider);

    final locale = localeAsync.valueOrNull;
    final themeMode = themeAsync.valueOrNull ?? ThemeMode.system;

    return MaterialApp(
      title: 'Bloody',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('uk'),
        Locale('es'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const InitialScreen(),
    );
  }
}

class InitialScreen extends ConsumerStatefulWidget {
  const InitialScreen({super.key});

  @override
  ConsumerState<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends ConsumerState<InitialScreen> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _updateWidgetOnStart();
  }

  Future<void> _updateWidgetOnStart() async {
    final donations = await DonationService.getDonations();

    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString('locale') ?? 'en';

    await WidgetService.updateWidget(
      donations: donations,
      locale: locale,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(onFinish: () => setState(() => _showSplash = false));
    }

    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('${AppLocalizations.of(context)!.error}: $e'),),
      ),
      data: (user) => user == null ? const WelcomeScreen() : const HomeScreen(),
    );
  }
}