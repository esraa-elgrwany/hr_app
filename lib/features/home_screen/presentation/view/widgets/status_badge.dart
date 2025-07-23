import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusBadge extends StatelessWidget {
  String status;

  StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
          color: Color(0XFF37bf85).withOpacity(.2), borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Text(status,
            style: TextStyle(
                color: Color(0XFF37bf85),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold)),
      ),
    );
    ;
  }
}
