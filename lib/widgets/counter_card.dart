import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterCard extends StatelessWidget {
  final String title;
  final int currentCount;
  final int maxCount;
  final VoidCallback onIncrement;
  final IconData icon;
  final Color color;
  final bool disableButtonWhenMax;

  const CounterCard({
    super.key,
    required this.title,
    required this.currentCount,
    required this.maxCount,
    required this.onIncrement,
    required this.icon,
    required this.color,
    this.disableButtonWhenMax = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMax = currentCount >= maxCount;

    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 80,
              color: color,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.dancingScript(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$currentCount / $maxCount',
              style: GoogleFonts.quicksand(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: isMax ? Colors.green.shade600 : Colors.pink.shade500,
              ),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: maxCount > 0 ? currentCount / maxCount : 0,
              backgroundColor: Colors.grey.shade200,
              // Fix: Use Color.fromARGB or similar to avoid deprecated withOpacity
              valueColor: AlwaysStoppedAnimation<Color>(color.withAlpha(255 * 8 ~/ 10)), // 80% opacity
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 20),
            Text(
              isMax ? 'Goal Reached!' : 'Keep going, you got this!',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: isMax ? Colors.green.shade700 : Colors.grey.shade600,
              ),
            ),
            if (!disableButtonWhenMax || !isMax)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton.icon(
                  onPressed: isMax && disableButtonWhenMax ? null : onIncrement,
                  icon: const Icon(Icons.add),
                  label: Text(
                    isMax && disableButtonWhenMax ? 'Done for Today!' : 'Add One',
                    style: GoogleFonts.quicksand(),
                  ),
                  style: ElevatedButton.styleFrom(
                    // Fix: Ensure the color is always a Color? type
                    backgroundColor: isMax && disableButtonWhenMax
                        ? Colors.grey // Disabled color
                        : (Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ?? Colors.pink.shade300), // Fallback
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: GoogleFonts.quicksand(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}