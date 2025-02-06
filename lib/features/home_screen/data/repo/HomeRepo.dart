import 'package:dartz/dartz.dart';
import 'package:hr_app/features/home_screen/data/model/holiday_model.dart';
import 'package:hr_app/features/home_screen/data/model/salary_model.dart';
import '../../../../core/Failures/Failures.dart';
import '../../../auth/data/models/employee_model.dart';
import 'package:hr_app/features/home_screen/data/model/expenses_model.dart';

abstract class HomeRepo {
  Future<Either<Failures, ExpensesModel>> getExpenses();

  Future<Either<Failures, HolidayModel>> getHolidays();

  Future<Either<Failures, SalaryModel>> getSalarySlip();

  Future<Either<Failures, EmployeeModel>> getEmployee({required int uID});
}
