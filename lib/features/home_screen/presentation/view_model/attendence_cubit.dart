import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/core/cache/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../../core/Api_Services/Api-Manager.dart';
import '../../../../core/Failures/Failures.dart';
import '../../Data/Model/attend_model.dart';
import '../../Data/Repo/attend_repo_impl.dart';
import '../../Data/Repo/attend_repo.dart';
import 'attendence_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  Timer? _timer;
  int elapsedTime = 0;
  String? checkInTime;
  String? checkOutTime;
  static AttendanceCubit get(context) => BlocProvider.of(context);
  AttendanceCubit() : super(AttendanceInitial()) {
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime++;
      if (state is CheckInSuccess) {
        emit(CheckInSuccess(
          checkInTime: checkInTime ?? '--:--:--',
          elapsedTime: elapsedTime,
        ));
      } else if (state is CheckOutSuccess) {
        emit(CheckOutSuccess(
          checkInTime: checkInTime ?? '--:--:--',
          checkOutTime: checkOutTime,
          elapsedTime: elapsedTime,
        ));
      }
    });
  }


  void stopTimer() {
    _timer?.cancel();
  }
  String formatElapsedTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$secs";
  }

  String formatTime(String rawTime) {
    DateTime parsedTime = DateTime.parse(rawTime);
    return DateFormat('EEE, MMM d, yyyy - h:mm a').format(parsedTime);
  }
  String formatCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('EEE, MMM d, yyyy').format(now);
  }

  Future<void> handleCheckIn() async {
    if (checkInTime != null) {
      emit(CheckInFailure('Already checked in'));
      return;
    }
    emit(CheckInLoading());
    String currentTime = DateTime.now().toIso8601String();
    elapsedTime = 0;
    Map<String, dynamic> params = {
      "employee_id": CacheData.getEmployeeData(key: "employeeId") ?? 0,
      "check_in":currentTime,
      "in_mode": "systray",
      "in_country_name": "Egypt",
      "in_latitude": 30.0434000,
      "in_longitude": 31.2352,
      "in_browser": "mobile app"
    };
    ApiManager apiManager=ApiManager();
    AttendRepo attendRepo = AttendRepoImpl(apiManager);
    final Either<Failures, AttendModel> result = await attendRepo.checkIn(params);

    result.fold(
          (l) => emit(CheckInFailure(l.toString())),
          (r) {
        checkInTime = formatTime(currentTime);
        emit(CheckInSuccess(
          checkInTime: checkInTime!,
          elapsedTime: elapsedTime,
        ));
      },
    );
  }

  Future<void> handleCheckOut() async {
    if (checkOutTime != null) {
      emit(CheckOutFailure('Already checked out'));
      return;
    }
    emit(CheckOutLoading());
    String currentTime = DateTime.now().toIso8601String();
    Map<String, dynamic> params = {
      "employee_id": CacheData.getEmployeeData(key: "employeeId") ?? 0,
      "check_in": DateTime.now().toIso8601String(),
      "in_mode": "systray",
      "in_browser": "mobile app",
      "in_country_name": "Egypt",
      "in_latitude": 30.0434000,
      "in_longitude": 31.2352,
    };

    ApiManager apiManager=ApiManager();
    AttendRepo attendRepo = AttendRepoImpl(apiManager);
    final Either<Failures, AttendModel> result = await attendRepo.checkOut(params);

    result.fold(
          (failure) => emit(CheckOutFailure(failure.toString())),
          (attendance) {
        checkOutTime = formatTime(currentTime);
        emit(CheckOutSuccess(
          checkInTime: checkInTime ?? '--:--:--',
          checkOutTime: checkOutTime,
          elapsedTime: elapsedTime,
        ));
      },
    );
  }
}


