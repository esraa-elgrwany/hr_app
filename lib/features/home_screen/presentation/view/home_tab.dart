import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/cache/shared_preferences.dart';
import 'package:hr_app/features/home_screen/presentation/view/Expenses_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/holiday_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/salary_screen.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/attendence_cubit.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/attendence_state.dart';
import 'package:hr_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is CheckInFailure || state is CheckOutFailure) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                title: Text("Error"),
                content: Text(state is CheckInFailure
                    ? state.failures
                    : (state as CheckOutFailure).failures),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Text("Okay", style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            );
          }

          if (state is CheckInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    "Check In Successfully",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 4),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              ),
            );
          }

          if (state is CheckOutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    "Check Out Successfully",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 4),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = AttendanceCubit.get(context);
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(AppLocalizations.of(context)!.welcome,CacheData.getData(key: "employeeName")??""),
                  Card(
                    color: Theme.of(context).colorScheme.onBackground,
                    margin: EdgeInsets.all(16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTimeUnit(context, cubit.formattedElapsed.split(':')[0]), // Hours
                              _buildColon(context),
                              _buildTimeUnit(context, cubit.formattedElapsed.split(':')[1]), // Minutes
                              _buildColon(context),
                              _buildTimeUnit(context, cubit.formattedElapsed.split(':')[2]), // Seconds
                            ],
                          ),

                          SizedBox(height: 16.h),
                          Text(
                            cubit.formattedCurrentDayAndDate(),
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20.h),
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.checkIn,
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 16.sp),
                                      ),
                                      Text(
                                          cubit.checkInTime != null
                                              ? DateFormat('HH:mm:ss').format(cubit.checkInTime!)
                                              : '--:--:--',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.checkOut,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 16.sp),
                                      ),
                                      Text(
                                        cubit.checkOutTime != null
                                            ? DateFormat('HH:mm:ss').format(cubit.checkOutTime!)
                                            : '--:--:--',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              if (state is CheckInLoading || state is CheckOutLoading)
                                Positioned(
                                  child: Container(
                                    child: Center(child: CircularProgressIndicator(
                                      color: Colors.green,
                                    )),
                                    height: 50.h,
                                    width: double.infinity,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () => cubit.checkIn(),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                child: Text(
                                  AppLocalizations.of(context)!.checkIn,
                                  style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w500),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => cubit.checkOut(),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: Text(
                                  AppLocalizations.of(context)!.checkOut,
                                  style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildQuickAccess(context),
                ],
              ),
            ),
          );
        },
    );
  }


  Widget _buildHeader(String welcome,String user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/people_8532963.png",
            width: 44.w,
            height: 44.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(welcome,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Text(user,
                  style: TextStyle(fontSize: 18.sp, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildQuickAccess(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HolidayTab(),
                        ));
                  },
                  child: _buildQuickAccessCard(AppLocalizations.of(context)!.holiday,"assets/images/time_14859310.png",
                      Color(0XFFf2fafd), Color(0XFF4ea1d2), Color(0XFFf66259))),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExpensesTab(),
                        ));
                  },
                  child: _buildQuickAccessCard(
                      AppLocalizations.of(context)!.expenses,
                      "assets/images/budget_5381790.png",
                      Color(0XFFffeacf),
                      Color(0XFF1e115e),
                      Color(0XFF4d5da7))),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SalaryScreen(),
                  ));
            },
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32))),
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.salary,
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0XFF1e115e))),
                      ),
                    ),
                    Container(
                      width: 130.w,
                      height: 104.h,
                      decoration: BoxDecoration(
                          color: Color(0XFFeef2fb),
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(12),
                              topStart: Radius.circular(12),
                              bottomEnd: Radius.circular(32),
                              bottomStart: Radius.circular(12))),
                      child: Center(
                          child: Image.asset("assets/images/cost.png",width: 56.w,height: 56.h,)),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildTimeUnit(BuildContext context, String unit) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        unit,
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }

  Widget _buildColon(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        ":",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface, // ← change color here
        ),
      ),
    );
  }


  Widget _buildQuickAccessCard(String title, String img, Color color,
      Color txtColor, Color iconColor) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(32))),
      child: Container(
        width: 140.w,
        height: 140.h,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Image.asset(img,width: 56.w,height: 56.h,),
              SizedBox(height: 8.h),
              Text(title,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: txtColor)),
            ],
          ),
        ),
      ),
    );
  }
}
