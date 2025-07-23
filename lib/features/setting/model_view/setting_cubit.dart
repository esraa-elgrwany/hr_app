import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cache/shared_preferences.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  static SettingCubit get(context) => BlocProvider.of(context);

  SettingCubit() : super(SettingInitial()) {
    _loadSettings();
  }

  String languageCode = "en";
  ThemeMode modeApp = ThemeMode.light;
  bool isArabic = false;
  bool isDark = false;

  changeLanguage(String langCode) {
    languageCode = langCode;
    if (langCode == "ar") {
      isArabic = true;
    } else {
      isArabic = false;
    }
    CacheData.saveId(data: languageCode, key: "lang");
    CacheData.saveId(data: isArabic, key: "arabicSwitch");
    emit(ChangeLanguage());
  }

  changeMode(ThemeMode mode) {
    modeApp = mode;
    if (mode == ThemeMode.dark) {
      isDark = true;
    } else {
      isDark = false;
    }
    CacheData.saveId(data: modeApp.toString(), key: "mode");
    CacheData.saveId(data: isDark, key: "darkSwitch");
    emit(ChangeTheme());
  }

  Future<void> _loadSettings() async {
    languageCode = CacheData.getData(key: "lang") ?? "en";
    String? themeString = CacheData.getData(key: "mode") ?? "ThemeMode.light";
    isDark = CacheData.getData(key: "darkSwitch") ?? false;
    isArabic = CacheData.getData(key: "arabicSwitch") ?? false;
    if (themeString == "ThemeMode.dark") {
      modeApp = ThemeMode.dark;
      isDark = true;
    } else {
      modeApp = ThemeMode.light;
      isDark = false;
    }
    if (languageCode == "ar") {
      isArabic = true;
    } else {
      isArabic = false;
    }
    emit(SettingInitial());
  }
}
