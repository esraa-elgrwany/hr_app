import 'package:flutter/material.dart';

class HolidayIconBadge extends StatelessWidget {
  const HolidayIconBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.yellow,
      child: Icon(Icons.calendar_month, color: Colors.blue, size: 24),
    );
  }
}
