import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/api_services/api-manager.dart';
import '../../data/model/attend_model.dart';
import '../../data/repo/attend_repo.dart';
import '../../data/repo/attend_repo_impl.dart';
import 'attendence_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  static AttendanceCubit get(context) => BlocProvider.of(context);

  Timer? _timer;
  Duration _elapsed = Duration.zero;
  DateTime? _checkInTime;
  DateTime? _checkOutTime;
  int? attendanceId;
  bool _isCheckedIn = false;

  AttendanceCubit() : super(AttendanceInitial());

  bool get isCheckedIn => _isCheckedIn;
  DateTime? get checkInTime => _checkInTime;
  DateTime? get checkOutTime => _checkOutTime;


  String get formattedElapsed {
    final hours = _elapsed.inHours.toString().padLeft(2, '0');
    final minutes = (_elapsed.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  String formatCurrentDate() {
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
  }

  String formattedCurrentDayAndDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, d MMMM yyyy'); // e.g., Tuesday, 29 July 2025
    return formatter.format(now);
  }

  void startTimer() {
    _checkInTime = DateTime.now();
    _elapsed = Duration.zero;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _elapsed = DateTime.now().difference(_checkInTime!);
      emit(AttendanceTimerRunning(formattedElapsed));
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _elapsed = Duration.zero;
    emit(AttendanceTimerStopped());
  }

  Future<void> checkIn() async {
    if (_isCheckedIn) {
      emit(CheckInFailure("Already checked in. Please check out first."));
      return;
    }
    emit(CheckInLoading());

    String checkInTimeStr = formatCurrentDate();
    ApiManager apiManager = ApiManager();
    AttendRepo repo = AttendRepoImpl(apiManager);
    final result = await repo.checkIn(checkInTime: checkInTimeStr);
    result.fold(
      (l) {
        emit(CheckInFailure(l.errormsg));
      },
      (r) {
        _isCheckedIn = true;
        attendanceId = r?.result ?? 0;
        startTimer();
        print("check in${r.result}");
        emit(CheckInSuccess(r));
      },
    );
  }

  Future<void> checkOut() async {
    if (!_isCheckedIn ||attendanceId == null) {
      emit(CheckOutFailure("You haven't checked in yet."));
      return;
    }

    emit(CheckOutLoading());

    _checkOutTime = DateTime.now();
    String checkOutTimeStr =
    DateFormat("yyyy-MM-dd HH:mm:ss").format(_checkOutTime!);
    ApiManager apiManager = ApiManager();
    AttendRepo repo = AttendRepoImpl(apiManager);
    final result =
        await repo.checkOut(id: attendanceId!, checkoutTime: checkOutTimeStr);
    result.fold(
      (failure) {
        emit(CheckOutFailure(failure.errormsg));
      },
      (r) {
        _isCheckedIn = false;
        attendanceId=null;
        stopTimer();
        print("check out${r.result}");
        emit(CheckOutSuccess(r));
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
