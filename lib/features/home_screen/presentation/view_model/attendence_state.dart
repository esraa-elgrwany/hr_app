
abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class CheckInLoading extends AttendanceState {}

class CheckInSuccess extends AttendanceState {
  final String checkInTime;
  final int elapsedTime;

  CheckInSuccess({
    required this.checkInTime,
    required this.elapsedTime,
  });
}

class CheckInFailure extends AttendanceState {
  final String errorMessage;

  CheckInFailure(this.errorMessage);
}

class CheckOutLoading extends AttendanceState {}

class CheckOutSuccess extends AttendanceState {
  final String checkInTime;
  final String? checkOutTime;
  final int elapsedTime;

  CheckOutSuccess({
    required this.checkInTime,
    this.checkOutTime,
    required this.elapsedTime,
  });
}

class CheckOutFailure extends AttendanceState {
  final String errorMessage;

  CheckOutFailure(this.errorMessage);
}


