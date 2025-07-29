import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/utils/styles/colors.dart';
import 'package:hr_app/features/auth/presentation/view/login_screen.dart';
import 'package:hr_app/features/home_screen/presentation/view/holiday_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/home_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/news_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/notification_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';
import 'package:hr_app/features/setting/view/setting_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../view_model/attendence_cubit.dart';
import '../view_model/attendence_state.dart';
import 'Expenses_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List<Widget> tabs = [HomeTab(), NotificationTab(), NewsTab(),SettingScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AttendanceCubit(),
  child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          title: Text("HR App", style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold)),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(
              left: 8,right: 8,bottom: 8
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius:  BorderRadius.all(Radius.circular(36.r)),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(36.r)),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.shifting,
                  iconSize: 20,
                  elevation: 2,
                  onTap: (value) {
                    index = value;
                    setState(() {});
                  },
                  selectedItemColor:Theme.of(context).colorScheme.primary,
                  unselectedItemColor:Theme.of(context).colorScheme.primary,
                  currentIndex: index,
                  selectedLabelStyle: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),
                  unselectedLabelStyle:TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),
                  items: [
                    BottomNavigationBarItem(
                      backgroundColor:Theme.of(context).colorScheme.secondary,
                      icon: Icon(
                        Icons.home,
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                        backgroundColor:Theme.of(context).colorScheme.secondary,
                        icon: Icon(
                          Icons.notifications_on_rounded,
                        ),
                        label: "Notification"),
                    BottomNavigationBarItem(
                        backgroundColor:Theme.of(context).colorScheme.secondary,
                        icon: Icon(
                          Icons.newspaper,
                        ),
                        label: "News"),
                    BottomNavigationBarItem(
                      backgroundColor:Theme.of(context).colorScheme.secondary,
                      icon: Icon(
                        Icons.settings,
                      ),
                      label: "settings",
                    ),
                  ],
                ))),
        body: tabs[index]),
);
  }
}
