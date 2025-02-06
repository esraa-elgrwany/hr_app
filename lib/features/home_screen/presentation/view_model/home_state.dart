part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetExpensesLoading extends HomeState {}

class GetExpensesSuccess extends HomeState {
  ExpensesModel data;

  GetExpensesSuccess(this.data);
}

class GetExpensesError extends HomeState {
  Failures failures;

  GetExpensesError(this.failures);
}

class GetHolidaysLoading extends HomeState {}

class GetHolidaysSuccess extends HomeState {
  HolidayModel data;

  GetHolidaysSuccess(this.data);
}

class GetHolidaysError extends HomeState {
  Failures failures;

  GetHolidaysError(this.failures);
}

class GetEmployeeLoading extends HomeState {}

class GetEmployeeSuccess extends HomeState {
  EmployeeModel data;

  GetEmployeeSuccess(this.data);
}

class GetEmployeeError extends HomeState {
  String failures;

  GetEmployeeError(this.failures);
}
