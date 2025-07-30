import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/presentation/view/holiday_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view/salary_line_screen.dart';
import 'package:hr_app/features/home_screen/presentation/view/salary_screen.dart';
import 'package:hr_app/features/home_screen/presentation/view/screens/expenses_request_screen.dart';
import 'package:hr_app/features/home_screen/presentation/view/screens/holiday_request_screen.dart';
import 'package:hr_app/l10n/app_localizations.dart';
import 'core/cache/shared_preferences.dart';
import 'core/utils/observer.dart';
import 'core/utils/styles/my_theme.dart';
import 'features/auth/presentation/view/login_screen.dart';
import 'features/home_screen/presentation/view/Expenses_tab.dart';
import 'features/home_screen/presentation/view/home_screen.dart';
import 'features/setting/model_view/setting_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheData.init();
  String start;
  int? userId = CacheData.getData(key: "userId");
  if (userId == null) {
    start = LoginScreen.routeName;
  } else {
    start = HomeScreen.routeName;
  }
  runApp(BlocProvider(
  create: (context) => SettingCubit(),
  child: MyApp(start),
));
}

class MyApp extends StatelessWidget {
  String start;

  MyApp(this.start);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
    builder: (context, state) {
    return ScreenUtilInit(
        designSize: const Size(412, 870),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          localizationsDelegates:
          AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(SettingCubit.get(context).languageCode),
                debugShowCheckedModeBanner: false,
                initialRoute: HomeScreen.routeName,
                routes: {
                  HomeScreen.routeName: (context) => HomeScreen(),
                  LoginScreen.routeName: (context) => LoginScreen(),
                  ExpensesTab.routeName: (context) => ExpensesTab(),
                  HolidayTab.routeName: (context) => HolidayTab(),
                  HolidayRequestScreen.routeName: (context) => HolidayRequestScreen(),
                  ExpensesRequestScreen.routeName: (context) => ExpensesRequestScreen(),
                  SalaryScreen.routeName: (context) => SalaryScreen(),
                  SalaryLineScreen.routeName: (context) => SalaryLineScreen(),
                },
          themeMode: SettingCubit.get(context).modeApp,
          theme: MyThemeData.lightTheme,
          darkTheme: MyThemeData.darkTheme,
                ));
  },
);
  }
}

