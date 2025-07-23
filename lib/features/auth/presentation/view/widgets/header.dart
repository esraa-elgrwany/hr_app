import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: Colors.white,
            radius: 32,
            child:Image.asset("assets/images/login_12658121.png",width: 80.w,height: 80.h,)),
         SizedBox(width: 16.w),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF46a1cb)),
            ),
            Text(
              "Enter username and password",
              style: TextStyle(color: Colors.grey,fontSize:18.sp,
                fontWeight: FontWeight.w500,),
            ),
          ],
        ),
      ],
    );
  }
}
