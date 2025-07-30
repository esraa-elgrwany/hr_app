import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/data/model/salary_model.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/status_badge.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';
import 'package:hr_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class SalarySlipCard extends StatelessWidget{
  int index;

   SalarySlipCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
   SalaryResult slip=HomeCubit.get(context).salary[index];
    return Card(
      color: Theme.of(context).colorScheme.onBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.only(bottom:8,top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slip?.name??"no name",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 22.sp, color:Color(0XFF37bf85)),
                      SizedBox(width: 8.w),
                      Text(
                        slip.employeeId?[1]??"no employee",
                        style:  TextStyle(fontWeight: FontWeight.w500,
                          fontSize: 16.sp,),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month_rounded,
                              size: 18.sp, color:Color(0XFF37bf85)),
                          SizedBox(width: 8.w),
                          Text(
                              "${AppLocalizations.of(context)!.from}: ",
                              style: TextStyle(color:Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w600)),
                          Text(
                              "${slip.dateFrom}",
                              style: TextStyle(color:Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_rounded,
                              size: 18.sp, color:Color(0XFF37bf85)),
                          SizedBox(width: 8.w),
                          Text(
                              "${AppLocalizations.of(context)!.to}: ",
                              style: TextStyle(color:Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w600)),
                          Text(
                              "${slip.dateTo}",
                              style: TextStyle(color:Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                    ],
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              children: [
                Image.asset('assets/images/salary.png',width: 60.w,height: 60.h,), // add this image in assets
                SizedBox(height: 32.h,),
                StatusBadge(slip.state?.toUpperCase()??"no state"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}