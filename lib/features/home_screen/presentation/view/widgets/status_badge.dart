import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  String status;

  StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
          color: Color(0xFFe7fbef), borderRadius: BorderRadius.circular(12)),
      child: Text(status,
          style: TextStyle(
              color: Color(0XFF37bf85),
              fontSize: 14,
              fontWeight: FontWeight.bold)),
    );
    ;
  }
}
