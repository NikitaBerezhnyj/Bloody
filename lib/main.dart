import 'package:bloody/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloody/l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/user_service.dart';
import 'models/user.dart';

void main() {
  runApp(const BloodyApp());
}

class BloodyApp extends StatefulWidget {
  const BloodyApp({super.key});

  @override
  State<BloodyApp> createState() => _BloodyAppState();
}

class _BloodyAppState extends State<BloodyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? langCode = prefs.getString('locale');
    if (langCode != null) {
      setState(() {
        _locale = Locale(langCode);
      });
    }
  }

  Future<void> _updateLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);

    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloody',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      locale: _locale,
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
      home: InitialScreen(onLocaleChanged: _updateLocale),
    );
  }
}

class InitialScreen extends StatefulWidget {
  final Function(Locale) onLocaleChanged;

  const InitialScreen({super.key, required this.onLocaleChanged});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool _showSplash = true;
  Widget? _nextScreen;

  @override
  void initState() {
    super.initState();
    _decideStartScreen();
  }

  Future<void> _decideStartScreen() async {
    User? user = await UserService.getUser();
    setState(() {
      _nextScreen = user == null
          ? LoginScreen(onLocaleChanged: widget.onLocaleChanged)
          : HomeScreen(onLocaleChanged: widget.onLocaleChanged);
    });
  }

  void _onSplashFinish() {
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(onFinish: _onSplashFinish);
    } else {
      if (_nextScreen == null) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        return _nextScreen!;
      }
    }
  }
}
