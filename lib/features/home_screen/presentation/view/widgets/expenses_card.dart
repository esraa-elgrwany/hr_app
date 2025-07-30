import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/icon_badge.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/status_badge.dart';
import 'package:hr_app/features/setting/model_view/setting_cubit.dart';
import '../../view_model/home_cubit.dart';

class ExpensesCard extends StatelessWidget {
  int index;

  ExpensesCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 180.h,
          padding: EdgeInsets.all(8),
          child: Card(
            color:Theme.of(context).colorScheme.onBackground,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                        "${HomeCubit.get(context).expenses[index].name}",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600
                            )),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                      "${HomeCubit.get(context).expenses[index].product?.name}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                         )),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month_rounded,
                              size: 22.sp, color:Color(0XFF37bf85)),
                          SizedBox(width:8.w),
                          Text(
                              "${HomeCubit.get(context).expenses[index].date}",
                              style: TextStyle(color: Color(0XFF8e95a1),fontSize: 14.sp,fontWeight: FontWeight.w600)),
                        ],
                      ),
                      StatusBadge(HomeCubit.get(context).expenses[index].state?.toUpperCase()??"no state"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(alignment: SettingCubit.get(context).isArabic?Alignment.centerLeft:Alignment.centerRight, child: IconBadge(img: "assets/images/budget_7057639.png",)),
      ],
    );
  }
}
