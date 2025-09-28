import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

  void _updateLocale(Locale locale) {
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
      home: InitialScreen(onLocaleChanged: _updateLocale),
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
    );
  }
}

class InitialScreen extends StatelessWidget {
  final Function(Locale) onLocaleChanged;

  const InitialScreen({super.key, required this.onLocaleChanged});

  Future<Widget> _decideStartScreen() async {
    User? user = await UserService.getUser();
    if (user == null) {
      return LoginScreen(onLocaleChanged: onLocaleChanged);
    } else {
      return HomeScreen(onLocaleChanged: onLocaleChanged);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _decideStartScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}

