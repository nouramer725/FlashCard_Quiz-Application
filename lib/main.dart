import 'package:flashcard_quiz_app/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Settings/LocaleProvider.dart';
import 'Settings/ThemeProvider.dart';
import 'cubit/categories_cubit/cubit.dart';
import 'cubit/fhashcard_cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart'; // Add this line for easy_localization

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Load locale from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final locale = prefs.getString('locale') ?? 'en';

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''), // Add more locales if needed
        Locale('fr', ''), // Add more locales if needed
      ],
      path: 'assets/lang', // Make sure your JSON translation files are in this folder
      fallbackLocale: Locale('en', ''),
      startLocale: Locale(locale), // Load the locale from SharedPreferences
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          BlocProvider(create: (context) => CategoriesCubit()..createDatabase()),
          BlocProvider(create: (context) => FlashCardsCubit()..createDatabase()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, child) {
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          locale: context.locale, // Use the context locale from easy_localization
          supportedLocales: context.supportedLocales, // Use supported locales from easy_localization
          localizationsDelegates: context.localizationDelegates, // Use localization delegates from easy_localization
          home: const SplashScreen(),
        );
      },
    );
  }
}
