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
      child: Image.asset(img,width:52.w ,height: 52.h,)
    );
  }
}
