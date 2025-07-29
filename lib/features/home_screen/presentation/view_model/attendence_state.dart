
import 'package:hr_app/features/home_screen/data/model/attend_out_model.dart';

import '../../../../core/failures/failures.dart';
import '../../data/model/attend_model.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class CheckInLoading extends AttendanceState {}

class CheckInSuccess extends AttendanceState {
  AttendModel model;
  CheckInSuccess(
   this.model
  );
}

class CheckInFailure extends AttendanceState {
  String failures;

  CheckInFailure(this.failures);
}

class CheckOutLoading extends AttendanceState {}

class CheckOutSuccess extends AttendanceState {
  AttendOutModel model;

  CheckOutSuccess(this.model);
}

class CheckOutFailure extends AttendanceState {
  String failures;

  CheckOutFailure(this.failures);
}
class AttendanceTimerRunning extends AttendanceState {
  final String duration;
  AttendanceTimerRunning(this.duration);
}

class AttendanceTimerStopped extends AttendanceState {}


