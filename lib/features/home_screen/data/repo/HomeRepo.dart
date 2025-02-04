import 'package:dartz/dartz.dart';
import '../../../../core/Failures/Failures.dart';
import '../../../auth/data/models/employee_model.dart';
import '../Model/GetTimeOff.dart';
import 'package:hr_app/features/home_screen/data/model/expenses_model.dart';

abstract class HomeRepo {
  Future<Either<Failures, ExpensesModel>> getExpenses();
  Future<Either<Failures, GetTimeOff>> getTimeOff();
  Future<Either<Failures, EmployeeModel>> getEmployee();
}
