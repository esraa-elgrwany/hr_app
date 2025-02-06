import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/features/auth/presentation/view/login_screen.dart';
import 'package:hr_app/features/home_screen/presentation/view/holiday_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/home_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/news_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/notification_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';
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
  List<Widget> tabs = [HomeTab(), NotificationTab(), NewsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text("HR App", style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF121645),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  CacheData.removeData("userId");
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                child: Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                )),
          ),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0XFFebf6fc),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: BottomNavigationBar(
                  backgroundColor: Color(0XFFebf6fc),
                  iconSize: 20,
                  elevation: 2,
                  onTap: (value) {
                    index = value;
                    setState(() {});
                  },
                  selectedItemColor: Color(0xFF121645),
                  unselectedItemColor: Color(0xFF121645),
                  currentIndex: index,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.notifications_on_rounded,
                        ),
                        label: "Notification"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.newspaper,
                        ),
                        label: "News"),
                  ],
                ))),
        body: tabs[index]);
  }
}
