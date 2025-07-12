import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:girly_todo_app/pages/water_counter_page.dart';
import 'package:girly_todo_app/pages/facewash_counter_page.dart';
import 'package:girly_todo_app/pages/moisturizer_counter_page.dart';
import 'package:girly_todo_app/pages/todo_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Fix applied here: Added 'const' to the list initialization.
  // The individual pages (WaterCounterPage, etc.) were already const in previous fixes.
  final List<Widget> _pages = const [
    WaterCounterPage(),
    FacewashCounterPage(),
    MoisturizerCounterPage(),
    TodoListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_outlined),
            activeIcon: Icon(Icons.water_drop),
            label: 'Water',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.clean_hands_outlined),
            activeIcon: Icon(Icons.clean_hands),
            label: 'Facewash',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.spa_outlined),
            activeIcon: Icon(Icons.spa),
            label: 'Moisturizer',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            activeIcon: Icon(Icons.check_box),
            label: 'To-Do',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        unselectedLabelStyle: GoogleFonts.quicksand(),
      ),
    );
  }
}