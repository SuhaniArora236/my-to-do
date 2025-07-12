import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Removed unused import: import 'package:intl/intl.dart';
// Removed unused import: import 'package:google_fonts/google_fonts.dart';
import 'package:girly_todo_app/models/daily_counter_data.dart';
import 'package:girly_todo_app/widgets/counter_card.dart';

class MoisturizerCounterPage extends StatefulWidget {
  const MoisturizerCounterPage({super.key});

  @override
  State<MoisturizerCounterPage> createState() => _MoisturizerCounterPageState();
}

class _MoisturizerCounterPageState extends State<MoisturizerCounterPage> {
  late Box<DailyCounterData> _moisturizerCounterBox;
  int _currentMoisturizerCount = 0;
  static const int _maxMoisturizerCount = 1;

  @override
  void initState() {
    super.initState();
    _moisturizerCounterBox = Hive.box<DailyCounterData>('moisturizerCounterBox');
    _loadMoisturizerCount();
  }

  void _loadMoisturizerCount() {
    final storedData = _moisturizerCounterBox.get('moisturizer');
    final today = DateTime.now();
    final todayWithoutTime = DateTime(today.year, today.month, today.day);

    if (storedData == null || storedData.lastUpdatedDate.isBefore(todayWithoutTime)) {
      _currentMoisturizerCount = 0;
      _moisturizerCounterBox.put(
        'moisturizer',
        DailyCounterData(count: _currentMoisturizerCount, lastUpdatedDate: todayWithoutTime),
      );
    } else {
      _currentMoisturizerCount = storedData.count;
    }
    setState(() {});
  }

  void _incrementMoisturizer() {
    if (_currentMoisturizerCount < _maxMoisturizerCount) {
      setState(() {
        _currentMoisturizerCount++;
      });
      final today = DateTime.now();
      final todayWithoutTime = DateTime(today.year, today.month, today.day);
      _moisturizerCounterBox.put(
        'moisturizer',
        DailyCounterData(count: _currentMoisturizerCount, lastUpdatedDate: todayWithoutTime),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('You\'ve moisturized for today! Your skin thanks you!'), // Fix: Add const
          backgroundColor: Colors.pink.shade300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moisturizer Tracker'),
      ),
      body: Center(
        child: CounterCard( // Fix: Add const
          title: 'Moisturizer Applied',
          currentCount: _currentMoisturizerCount,
          maxCount: _maxMoisturizerCount,
          onIncrement: _incrementMoisturizer,
          icon: Icons.spa,
          color: Colors.purple.shade100,
          disableButtonWhenMax: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _currentMoisturizerCount < _maxMoisturizerCount ? _incrementMoisturizer : null,
        backgroundColor: _currentMoisturizerCount < _maxMoisturizerCount
            ? Theme.of(context).floatingActionButtonTheme.backgroundColor
            : Colors.grey,
        child: const Icon(Icons.add, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}