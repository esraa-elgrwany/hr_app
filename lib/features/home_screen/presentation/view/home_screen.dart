import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/features/auth/presentation/view/login_screen.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../view_model/attendence_cubit.dart';
import '../view_model/attendence_state.dart';
import 'Expenses_tab.dart';

class HomeScreen extends StatefulWidget{
  static const String routeName = "homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return
    MultiBlocProvider(
  providers: [
    BlocProvider(
        create: (_) => AttendanceCubit(),
),
    BlocProvider(
      create: (context) => HomeCubit()..getEmployee(),
    ),
  ],
  child: Scaffold(
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
                    child: Icon(Icons.logout_outlined,color: Colors.white,)),
              ),
            ),
            body: BlocProvider(
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
                                child: Text("okay",
                                    style: TextStyle(color: Colors.green))),
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
                                child: Text("okay",
                                    style: TextStyle(color: Colors.green))),
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
                              margin: EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AttendanceCubit.get(context)
                                          .formatElapsedTime(
                                              AttendanceCubit.get(context)
                                                  .elapsedTime),
                                      style: TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 20),
                                    // Display current date
                                    Text(
                                      AttendanceCubit.get(context)
                                          .formatCurrentDate(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 20),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Check In',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              AttendanceCubit.get(context)
                                                      .checkInTime ??
                                                  '--:--:--',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 50),
                                        Column(
                                          children: [
                                            Text(
                                              'Check Out',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              AttendanceCubit.get(context)
                                                      .checkOutTime ??
                                                  '--:--:--',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
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
                                        ),
                                        ElevatedButton(
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
                ))
        ),
);
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple,
            child:Icon(Icons.person_rounded,color: Colors.white,)
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Welcome',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Administrator',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceInfo() {
    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('متبقي لانتهاء الدوام',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('00 : 00 : 00',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeInfo(
                    'وقت الحضور', '٣:٣٥ م', LucideIcons.logIn, Colors.blue),
                _buildTimeInfo(
                    'وقت الانصراف', '٩:٣٦ م', LucideIcons.logOut, Colors.red),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.check),
                  SizedBox(width: 8),
                  Text('حضور'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeInfo(String label, String time, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        SizedBox(height: 8),
        Text(label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Text(time, style: TextStyle(fontSize: 16, color: Colors.grey)),
      ],
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
                    Navigator.pushNamed(context,ExpensesTab.routeName);
                  },
                  child: _buildQuickAccessCard('Holidays', LucideIcons.calendar,Color(0XFFf2fafd),Color(0XFF4ea1d2),Color(0XFFf66259))),
              InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>ExpensesTab() ,));
                },
                  child: _buildQuickAccessCard('Expenses', LucideIcons.calculator,Color(0XFFffeacf),Color(0XFF1e115e),Color(0XFF4d5da7))),
            ],
          ),
          SizedBox(height: 20,),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32)
            )),
            child: Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              height: 110,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text("Salary",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:Color(0XFF1e115e) )),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 140,
                    decoration: BoxDecoration(
                      color:Color(0XFFeef2fb),
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(12),
                          topStart: Radius.circular(12),
                          bottomEnd: Radius.circular(32),
                          bottomStart: Radius.circular(12)
                      )
                    ),
                    child:
                    Center(child: Icon(LucideIcons.fileText, size: 40,color:Color(0XFF1e115e),)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickAccessCard(String title, IconData icon,Color color, Color txtColor,Color iconColor) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(32)
      )),
      child: Container(
        width: 110,
        height: 110,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 34,color: iconColor,),
              SizedBox(height: 8),
              Text(title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: txtColor)),
            ],
          ),
        ),
      ),
    );
  }
}
