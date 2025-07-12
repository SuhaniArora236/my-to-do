import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Removed unused import: import 'package:intl/intl.dart';
// Removed unused import: import 'package:google_fonts/google_fonts.dart';
import 'package:girly_todo_app/models/daily_counter_data.dart';
import 'package:girly_todo_app/widgets/counter_card.dart';

class WaterCounterPage extends StatefulWidget {
  const WaterCounterPage({super.key});

  @override
  State<WaterCounterPage> createState() => _WaterCounterPageState();
}

class _WaterCounterPageState extends State<WaterCounterPage> {
  late Box<DailyCounterData> _waterCounterBox;
  int _currentWaterCount = 0;
  static const int _maxWaterCount = 8;

  @override
  void initState() {
    super.initState();
    _waterCounterBox = Hive.box<DailyCounterData>('waterCounterBox');
    _loadWaterCount();
  }

  void _loadWaterCount() {
    final storedData = _waterCounterBox.get('water');
    final today = DateTime.now();
    final todayWithoutTime = DateTime(today.year, today.month, today.day);

    if (storedData == null || storedData.lastUpdatedDate.isBefore(todayWithoutTime)) {
      _currentWaterCount = 0;
      _waterCounterBox.put(
        'water',
        DailyCounterData(count: _currentWaterCount, lastUpdatedDate: todayWithoutTime),
      );
    } else {
      _currentWaterCount = storedData.count;
    }
    setState(() {});
  }

  void _incrementWater() {
    if (_currentWaterCount < _maxWaterCount) {
      setState(() {
        _currentWaterCount++;
      });
      final today = DateTime.now();
      final todayWithoutTime = DateTime(today.year, today.month, today.day);
      _waterCounterBox.put(
        'water',
        DailyCounterData(count: _currentWaterCount, lastUpdatedDate: todayWithoutTime),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('You\'ve reached your daily water goal!'), // Fix: Add const
          backgroundColor: Colors.pink.shade300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Hydration'),
      ),
      body: Center(
        child: CounterCard( // Fix: Add const
          title: 'Water Glasses',
          currentCount: _currentWaterCount,
          maxCount: _maxWaterCount,
          onIncrement: _incrementWater,
          icon: Icons.water_drop,
          color: Colors.blue.shade200,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementWater,
        child: const Icon(Icons.add, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}