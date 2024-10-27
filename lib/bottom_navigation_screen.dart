import 'package:flashcard_quiz_app/Settings/Settings.dart';
import 'package:flashcard_quiz_app/views/categories_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // Add this import
import 'explore_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  // Add a third widget here to match the number of BottomNavigationBar items
  static List<Widget> Screens = [
    ExploreScreen(),
    CategoriesView(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Only show the AppBar for the Explore screen (index 0)
      appBar: _selectedIndex == 0
          ? AppBar(
        leading: Icon(Icons.quiz_rounded),
        title: Row(
          children: [
            Text(
              'topics_to'.tr(), // Key for 'Topics To'
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'explore'.tr(), // Key for 'Explore'
              style: TextStyle(
                color: Colors.purple[200],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                label: 'explore'.tr(), // Key for 'Explore'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_membership_outlined),
                label: 'flashcards'.tr(), // Key for 'Flashcards'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'settings'.tr(), // Key for 'Settings'
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: changeBottom,
            selectedIconTheme: IconThemeData(
              size: 32.0, // Increase size of selected icon
            ),
            unselectedIconTheme: IconThemeData(
              size: 24.0,
              color: Colors.grey.shade600, // Color of unselected icon
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
