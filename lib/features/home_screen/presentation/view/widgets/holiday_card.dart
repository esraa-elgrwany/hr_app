import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/icon_badge.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/status_badge.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';

class HolidayCard extends StatelessWidget {
  int index;

  HolidayCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200.h,
          padding: EdgeInsets.all(8),
          child: Card(
            color: Theme.of(context).colorScheme.onBackground,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                        "${HomeCubit.get(context).holidays[index].name ?? "no name"}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            )),
                  ),
                  SizedBox(height: 12.h,),
                  Text(
                      "${HomeCubit.get(context).holidayReason[index] ?? "no reason"}",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 12.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,
                                  size: 18.sp, color:Color(0XFF37bf85)),
                              SizedBox(width: 8.w),
                              Text(
                                  "From: ",
                                  style: TextStyle(color:Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w600)),
                              Text(
                                  "${HomeCubit.get(context).holidays[index].requestDateFrom}",
                                  style: TextStyle(color:Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 8.h,),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,
                                  size: 18.sp, color:Color(0XFF37bf85)),
                              SizedBox(width: 8.w),
                              Text(
                                  "To: ",
                                  style: TextStyle(color:Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w600)),
                              Text(
                                  "${HomeCubit.get(context).holidays[index].requestDateTo}",
                                  style: TextStyle(color:Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                      StatusBadge(
                          "${HomeCubit.get(context).holidays[index].state}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 0,
          child: Align(
              alignment: Alignment.centerRight, child: IconBadge(img: "assets/images/3d-calendar.png")),
        ),
      ],
    );
  }
}
