part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class ChangeTheme extends SettingState {
}

class ChangeLanguage extends SettingState {
}
