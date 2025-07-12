import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:girly_todo_app/models/daily_counter_data.dart';
import 'package:girly_todo_app/models/todo_item.dart';
import 'package:girly_todo_app/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(DailyCounterDataAdapter());
  Hive.registerAdapter(TodoItemAdapter());

  await Hive.openBox<DailyCounterData>('waterCounterBox');
  await Hive.openBox<DailyCounterData>('facewashCounterBox');
  await Hive.openBox<DailyCounterData>('moisturizerCounterBox');
  await Hive.openBox<TodoItem>('todoItemsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Girly To-Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pink.shade400,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.purple.shade200),

        textTheme: GoogleFonts.dancingScriptTextTheme(Theme.of(context).textTheme).copyWith(
          bodyLarge: GoogleFonts.quicksand(fontSize: 16, color: Colors.pink.shade900),
          bodyMedium: GoogleFonts.quicksand(fontSize: 14, color: Colors.pink.shade800),
          bodySmall: GoogleFonts.quicksand(fontSize: 12, color: Colors.pink.shade700),
          labelLarge: GoogleFonts.quicksand(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink.shade200,
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
          titleTextStyle: GoogleFonts.dancingScript(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pinkAccent.shade100,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),

        // Fix: Use CardThemeData instead of CardTheme
        cardTheme: CardThemeData(
          color: Colors.pink.shade50,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink.shade300,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.pink.shade600,
            textStyle: GoogleFonts.quicksand(fontSize: 14),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          // Fix: Use Color.fromARGB or similar to avoid deprecated withOpacity
          fillColor: Colors.pink.shade100.withAlpha(255 ~/ 2), // ~ / 2 for 50% opacity
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.pink.shade400, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.pink.shade200, width: 1),
          ),
          labelStyle: GoogleFonts.quicksand(color: Colors.pink.shade700),
          // Fix: Use Color.fromARGB or similar for hintStyle
          hintStyle: GoogleFonts.quicksand(color: Colors.pink.shade400.withAlpha(255 * 7 ~/ 10)), // 70% opacity
        ),

        iconTheme: IconThemeData(
          color: Colors.pink.shade600,
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.pink.shade200,
          selectedItemColor: Colors.purple.shade600,
          unselectedItemColor: Colors.pink.shade700,
          elevation: 5,
          selectedLabelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.quicksand(),
        ),

        // Fix: Use WidgetStateProperty and WidgetState
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.purple.shade400;
            }
            return Colors.pink.shade300;
          }),
          checkColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}