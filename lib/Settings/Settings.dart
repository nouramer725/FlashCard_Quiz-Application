import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart'; // Add this for localization
import 'LocaleProvider.dart';
import 'ThemeProvider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For storing preferences

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Function to save the selected language in SharedPreferences
  Future<void> _saveLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()), // Use .tr() for translations
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Dark/Light Mode
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text('theme_mode'.tr()), // Translatable text
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ),
          const Divider(),

          // Switch Language
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('language'.tr()), // Translatable text
            trailing: DropdownButton<Locale>(
              value: localeProvider.locale, // Get the current locale
              onChanged: (Locale? locale) async {
                if (locale != null) {
                  await _saveLocale(locale); // Save the selected locale in preferences
                  context.setLocale(locale); // Update the app's locale
                  localeProvider.setLocale(locale); // Also update LocaleProvider
                }
              },
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
                DropdownMenuItem(value: Locale('fr'), child: Text('French')),

                // Add more languages as needed
              ],
            ),
          ),
          const Divider(),

          // About App
          ListTile(
            leading: const Icon(Icons.info),
            title: Text('about_app'.tr()), // Translatable text
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Flashcard Quiz App',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.info),
                children: [
                  Text('about_description'.tr()), // Translatable description
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
