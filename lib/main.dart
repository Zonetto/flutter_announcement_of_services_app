import 'package:announcement_of_services/utils/constant/color.dart';
import 'package:announcement_of_services/view/splash_screen.dart';
import 'package:announcement_of_services/view/start_screen.dart';
import 'package:announcement_of_services/view_model/view_model_auth.dart';
import 'package:announcement_of_services/view_model/view_model_fetch_user.dart';
import 'package:announcement_of_services/view_model/view_model_request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'components/shared/network/local/cache_helper.dart';
import 'generated/l10n.dart';
import 'view/bottom_navigation_bar_screen.dart';
import 'view/lodaing_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // Platform.isAndroid
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCnSlXad2dN_lYXEjg15uuY8C18L2hchqw',
      appId: '1:173236485210:android:95e8fab76659b783faac63',
      messagingSenderId: '173236485210',
      projectId: 'flutterhomeservice-73056',
    ),
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    CacheHelper.getDataBoolean(key: 'mode') == true
        ? ThemeMode.light
        : ThemeMode.dark,
  );
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ViewModelAuth>(
          create: (_) => ViewModelAuth(),
        ),
        ChangeNotifierProvider<ViewModelFetch>(
          create: (_) => ViewModelFetch(),
        ),
        ChangeNotifierProvider<ViewModelRequest>(
          create: (_) => ViewModelRequest()
            ..fetchWithServicesProviderDetails()
            ..fetchWithUserDetails(),
        ),
      ],
      child: Consumer<ViewModelAuth>(
        builder: (ctx, auth, _) => ValueListenableBuilder(
            valueListenable: themeNotifier,
            builder: (_, currentMode, __) {
              return MaterialApp(
                theme: lightMode(),
                darkTheme: darkMode(),
                themeMode: currentMode,
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
                    ? const SplashScreen(
                        route: BottomNavigationBarScreen(),
                      )
                    : FutureBuilder(
                        future: auth.tryAuthLogin(),
                        builder: (ctx, snapShot) => (snapShot.connectionState ==
                                ConnectionState.waiting)
                            ? const LoadingScreen()
                            : const SplashScreen(
                                route: StartScreen(),
                              ),
                      ),
              );
            }),
      ),
    );
  }
}

ThemeData lightMode() {
  return ThemeData(
    iconTheme: IconThemeData(color: AppColor.darkShadeText),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColor.green,
    ),
    secondaryHeaderColor: AppColor.grey,
     bottomAppBarColor: AppColor.green,
    splashColor: AppColor.white,
    cardColor: AppColor.lightShade,
    scaffoldBackgroundColor: AppColor.white,
    hintColor: AppColor.darkShadeText,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColor.white,
      iconTheme: MaterialStateProperty.all<IconThemeData>(IconThemeData(
        color: AppColor.darkShadeText,
        size: 30,
      )),
      labelTextStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          color: AppColor.darkShadeText,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    ), bottomAppBarTheme: const BottomAppBarTheme(color: AppColor.green),
  );
}

ThemeData darkMode() {
  return ThemeData.dark().copyWith(
    //  textButtonTheme: TextButtonThemeData(style: ButtonStyle(backgroundColor: )),
    iconTheme: const IconThemeData(color: AppColor.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColor.white),
    ),
    secondaryHeaderColor: AppColor.darkShadeText,
        bottomAppBarColor: AppColor.darkShade,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColor.white),
    splashColor: AppColor.darkShadeText,
    hintColor: AppColor.whiteText,
    cardColor: AppColor.darkShadeText,
    scaffoldBackgroundColor: AppColor.colorTextBlack,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColor.darkShade,
      iconTheme: MaterialStateProperty.all<IconThemeData>(const IconThemeData(
        color: AppColor.white,
        size: 30,
      )),
      labelTextStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          color: AppColor.whiteText,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    ), bottomAppBarTheme: const BottomAppBarTheme(color: AppColor.darkShade),
  );
}
