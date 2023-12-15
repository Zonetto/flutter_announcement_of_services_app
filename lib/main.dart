import 'dart:io';

import 'package:announcement_of_services/view/complex_screen.dart';
import 'package:announcement_of_services/view/start_screen.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:announcement_of_services/view_model/view_model_fetch.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'view/categories_creen.dart';
import 'view/home_screen.dart';
import 'view/loadingScreen.dart';
import 'view/registration_option_screen.dart';
import 'view/service_details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyCnSlXad2dN_lYXEjg15uuY8C18L2hchqw',
          appId: '1:173236485210:android:95e8fab76659b783faac63',
          messagingSenderId: '173236485210',
          projectId: 'flutterhomeservice-73056',
        ))
      : await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('AIzaSyCnSlXad2dN_lYXEjg15uuY8C18L2hchqw'),
    appleProvider: AppleProvider.appAttest,
    androidProvider: AndroidProvider.debug,
  );

  runApp(
    // Builder(
    //   builder: (context) => MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider<ViewModelAuth>(
    //         create: (context) => ViewModelAuth(),
    //         // child: MaterialApp(
    //         //   locale: const Locale('ar'),
    //         //   localizationsDelegates: const [
    //         //     S.delegate,
    //         //     GlobalMaterialLocalizations.delegate,
    //         //     GlobalWidgetsLocalizations.delegate,
    //         //     GlobalCupertinoLocalizations.delegate
    //         //   ],
    //         //   debugShowCheckedModeBanner: false,
    //         //   supportedLocales: S.delegate.supportedLocales,
    //         //   home: const MainApp(), // Use MainApp as the home widget
    //         // ),
    //       ),
    //       ChangeNotifierProvider<ViewModelFetch>(
    //         create: (context) => ViewModelFetch(),
    //       )
    //     ],
    //   ),
    // ),

    MultiProvider(
      providers: [
        ChangeNotifierProvider<ViewModelAuth>(
          create: (_) => ViewModelAuth(),
        ),
        ChangeNotifierProvider<ViewModelFetch>(
          create: (_) => ViewModelFetch(),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //   return MaterialApp(home: const StartScreen());

    return Consumer<ViewModelAuth>(
      builder: (ctx, auth, _) => MaterialApp(
        locale: const Locale('ar'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        debugShowCheckedModeBanner: false,
        supportedLocales: S.delegate.supportedLocales,
        home: auth.isAuth!
            ? const ComplexScreen()
            : FutureBuilder(
                future: auth.tryAuthLogin(),
                builder: (ctx, snapShot) =>
                    (snapShot.connectionState == ConnectionState.waiting)
                        ? const LoadingScreen()
                        : const StartScreen(),
              ), // Use MainApp as the home widget
      ),
    );
  }
}
