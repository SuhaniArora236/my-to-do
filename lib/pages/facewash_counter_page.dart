import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Removed unused import: import 'package:intl/intl.dart';
// Removed unused import: import 'package:google_fonts/google_fonts.dart';
import 'package:girly_todo_app/models/daily_counter_data.dart';
import 'package:girly_todo_app/widgets/counter_card.dart';

class FacewashCounterPage extends StatefulWidget {
  const FacewashCounterPage({super.key});

  @override
  State<FacewashCounterPage> createState() => _FacewashCounterPageState();
}

class _FacewashCounterPageState extends State<FacewashCounterPage> {
  late Box<DailyCounterData> _facewashCounterBox;
  int _currentFacewashCount = 0;
  static const int _maxFacewashCount = 2;

  @override
  void initState() {
    super.initState();
    _facewashCounterBox = Hive.box<DailyCounterData>('facewashCounterBox');
    _loadFacewashCount();
  }

  void _loadFacewashCount() {
    final storedData = _facewashCounterBox.get('facewash');
    final today = DateTime.now();
    final todayWithoutTime = DateTime(today.year, today.month, today.day);

    if (storedData == null || storedData.lastUpdatedDate.isBefore(todayWithoutTime)) {
      _currentFacewashCount = 0;
      _facewashCounterBox.put(
        'facewash',
        DailyCounterData(count: _currentFacewashCount, lastUpdatedDate: todayWithoutTime),
      );
    } else {
      _currentFacewashCount = storedData.count;
    }
    setState(() {});
  }

  void _incrementFacewash() {
    if (_currentFacewashCount < _maxFacewashCount) {
      setState(() {
        _currentFacewashCount++;
      });
      final today = DateTime.now();
      final todayWithoutTime = DateTime(today.year, today.month, today.day);
      _facewashCounterBox.put(
        'facewash',
        DailyCounterData(count: _currentFacewashCount, lastUpdatedDate: todayWithoutTime),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('You\'ve cleansed your face for today!'), // Fix: Add const
          backgroundColor: Colors.pink.shade300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facewash Tracker'),
      ),
      body: Center(
        child: CounterCard( // Fix: Add const
          title: 'Face Washes',
          currentCount: _currentFacewashCount,
          maxCount: _maxFacewashCount,
          onIncrement: _incrementFacewash,
          icon: Icons.clean_hands,
          color: Colors.lightGreen.shade200,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementFacewash,
        child: const Icon(Icons.add, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}