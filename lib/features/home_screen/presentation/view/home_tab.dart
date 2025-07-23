import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/presentation/view/Expenses_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/holiday_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/attendence_cubit.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/attendence_state.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceCubit(),
      child: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is CheckInFailure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Text(state.errorMessage),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:
                          Text("okay", style: TextStyle(color: Colors.green))),
                ],
              ),
            );
          }
          if (state is CheckOutFailure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Text(state.errorMessage),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:
                          Text("okay", style: TextStyle(color: Colors.green))),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
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
                          Text(
                            AttendanceCubit.get(context).formatElapsedTime(
                                AttendanceCubit.get(context).elapsedTime),
                            style: TextStyle(
                                fontSize: 48.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16.h),
                          // Display current date
                          Text(
                            AttendanceCubit.get(context).formatCurrentDate(),
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Check In',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 18.sp),
                                  ),
                                  Text(
                                    AttendanceCubit.get(context).checkInTime ??
                                        '--:--:--',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Check Out',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18.sp),
                                  ),
                                  Text(
                                    AttendanceCubit.get(context).checkOutTime ??
                                        '--:--:--',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BlocListener<AttendanceCubit, AttendanceState>(
                                  listener: (context, state) {
                                    if (state is CheckInFailure) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text("Error"),
                                          content: Text(state.errorMessage),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("okay",
                                                    style: TextStyle(
                                                        color: Colors.green))),
                                          ],
                                        ),
                                      );
                                    } else if (state is CheckInSuccess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Center(
                                              child: Text(
                                                "Check In Successfully",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp),
                                              ),
                                            ),
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 4),
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(24),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 4)),
                                      );
                                    }
                                  },
                                  child: ElevatedButton(
                                    onPressed: () {
                                      AttendanceCubit.get(context)
                                          .handleCheckIn();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    child: Text(
                                      'Check In',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                              BlocListener<AttendanceCubit, AttendanceState>(
                                listener: (context, state) {
                                  if (state is CheckOutFailure) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Error"),
                                        content: Text(state.errorMessage),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("okay",
                                                  style: TextStyle(
                                                      color: Colors.green))),
                                        ],
                                      ),
                                    );
                                  } else if (state is CheckOutSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Center(
                                            child: Text(
                                              "Check out Successfully",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 4),
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(24),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 4)),
                                    );
                                  }
                                },
                               child:  ElevatedButton(
                                    onPressed: () {
                                      AttendanceCubit.get(context)
                                          .handleCheckOut();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    child: Text(
                                      'Check Out',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
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
      ),
    );
  }

  Widget _buildHeader() {
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
              Text('Welcome',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Text("Administrator",
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
                  child: _buildQuickAccessCard('Holidays',"assets/images/time_14859310.png",
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
                      'Expenses',
                      "assets/images/budget_5381790.png",
                      Color(0XFFffeacf),
                      Color(0XFF1e115e),
                      Color(0XFF4d5da7))),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Card(
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
                      child: Text("Salary Slip",
                          style: TextStyle(
                              fontSize: 22.sp,
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
          )
        ],
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
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: txtColor)),
            ],
          ),
        ),
      ),
    );
  }
}
