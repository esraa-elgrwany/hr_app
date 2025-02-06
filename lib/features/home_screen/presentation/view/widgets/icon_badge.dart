import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.yellow,
      child: Icon(Icons.attach_money, color: Colors.blue, size: 24),
    );
  }
}
