import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/auth/presentation/view/login_screen.dart';
import 'package:hr_app/l10n/app_localizations.dart';
import '../../../core/cache/shared_preferences.dart';
import '../../../core/utils/styles/colors.dart';
import '../model_view/setting_cubit.dart';
class SettingScreen extends StatefulWidget {
  static const String routeName = "settingScreen";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .8,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Card(
                  elevation: 8,
                  color: Theme.of(context).colorScheme.onBackground,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.lang,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 18.sp)),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(AppLocalizations.of(context)!.en,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 16.sp)),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              "assets/images/lang.png",
                              width: 40.w,
                              height: 40.h,
                            ),
                          ],
                        ),
                        Divider(
                          endIndent: 16,
                          indent: 16,
                          color: primaryColor,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.translate,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 18.sp)),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(AppLocalizations.of(context)!.ar,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 16.sp)),
                              ],
                            ),
                            Spacer(),
                            BlocBuilder<SettingCubit, SettingState>(
                                builder: (context, state) {
                                  return Switch(
                                    value: SettingCubit.get(context).isArabic,
                                    activeColor: SettingCubit.get(context).isDark
                                        ? primaryColor
                                        : Colors.white,
                                    activeTrackColor:
                                    SettingCubit.get(context).isDark
                                        ? Colors.grey[100]
                                        : primaryColor,
                                    inactiveTrackColor:
                                    SettingCubit.get(context).isDark
                                        ? Colors.grey
                                        : thirdPrimary,
                                    onChanged: (value) {
                                      SettingCubit.get(context)
                                          .changeLanguage(value ? "ar" : "en");
                                    },
                                  );
                                }),
                          ],
                        ),
                        Divider(
                          endIndent: 16,
                          indent: 16,
                          color: primaryColor,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.theme,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 18.sp)),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(AppLocalizations.of(context)!.light,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 16.sp)),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              "assets/images/eclipse_672838.png",
                              width: 40.h,
                              height: 40.w,
                            ),
                          ],
                        ),
                        Divider(
                          endIndent: 16,
                          indent: 16,
                          color: primaryColor,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.dark,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 18.sp)),
                              ],
                            ),
                            Spacer(),
                            BlocBuilder<SettingCubit, SettingState>(
                              builder: (context, state) {
                                return Switch(
                                  value: SettingCubit.get(context).isDark,
                                  activeColor: SettingCubit.get(context).isDark
                                      ? primaryColor
                                      : Colors.white,
                                  activeTrackColor:
                                  SettingCubit.get(context).isDark
                                      ? Colors.grey[100]
                                      : primaryColor,
                                  inactiveTrackColor:
                                  SettingCubit.get(context).isDark
                                      ? Colors.grey
                                      : thirdPrimary,
                                  onChanged: (value) {
                                    SettingCubit.get(context).changeMode(value
                                        ? ThemeMode.dark
                                        : ThemeMode.light);
                                    print(
                                        "mode+++++++++++++++++${SettingCubit.get(context).modeApp}");
                                    print(
                                        "dark+++++++++++++++++${SettingCubit.get(context).isDark}");
                                  },
                                );
                              },
                            )
                          ],
                        ),
                        Divider(
                          endIndent: 16,
                          indent: 16,
                          color: primaryColor,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.logout,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 18.sp)),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () async{
                                  CacheData.removeData("userId");
                                  CacheData.removeData("password");
                                  CacheData.removeData("employeeId");
                                  CacheData.removeData("employeeName");
                                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                                },
                                child: Image.asset(
                                  "assets/images/logout_4263209.png",
                                  width: 40.w,
                                  height: 40.h,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
