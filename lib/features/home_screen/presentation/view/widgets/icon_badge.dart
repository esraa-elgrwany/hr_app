import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconBadge extends StatelessWidget {
  String img;
   IconBadge({super.key,required this.img});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.yellow,
      child: Image.asset(img,width:48.w ,height: 48.h,)
    );
  }
}
