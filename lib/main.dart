import 'package:announcement_of_services/view/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'view/add_photo_screen.dart';

void main() {
  runApp(
    MaterialApp(
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      home: const MainApp(), // Use MainApp as the home widget
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const StartScreen();
  }
}
