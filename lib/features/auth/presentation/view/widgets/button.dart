import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  String txt;

  Button({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width / 2,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0XFF1d194a),
        borderRadius: BorderRadiusDirectional.circular(12),
      ),
      child: Center(child: Text(txt, style: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),)),
    );
  }
}
