import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/cache/shared_preferences.dart';
import 'core/utils/observer.dart';
import 'features/auth/presentation/view/login_screen.dart';
import 'features/home_screen/presentation/view/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await CacheData.init();
  String start;
  int? userId=CacheData.getData(key: "userId");
  if(userId==null){
    start=LoginScreen.routeName;
  }else{
    start=HomeScreen.routeName;
  }
  runApp( MyApp( start));
}

class MyApp extends StatelessWidget {
  String start;
  MyApp(this.start);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 870),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) =>MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute:start,
            routes: {
              HomeScreen.routeName: (context) => HomeScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
            }
        )
    );
  }
}
