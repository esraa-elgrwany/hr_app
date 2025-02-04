part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class GetExpensesLoading extends HomeState {}
class  GetExpensesSuccess extends HomeState {
 ExpensesModel data;
  GetExpensesSuccess(this.data);
}

class  GetExpensesError extends HomeState {
  Failures failures;
  GetExpensesError(this.failures);
}

class GetTimeOffLoading extends HomeState {}

class GetTimeOffError extends HomeState {
  Failures failures;
  GetTimeOffError(this.failures);
}
class GetEmployeeLoading extends HomeState {}

class  GetEmployeeSuccess extends HomeState {
  EmployeeModel data;
  GetEmployeeSuccess(this.data);
}

class  GetEmployeeError extends HomeState {
  String failures;
  GetEmployeeError(this.failures);
}
