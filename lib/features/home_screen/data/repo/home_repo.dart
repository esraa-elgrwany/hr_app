import 'package:dartz/dartz.dart';
import 'package:hr_app/features/home_screen/data/model/employee_model.dart';
import 'package:hr_app/features/home_screen/data/model/expenses_model.dart';
import 'package:hr_app/features/home_screen/data/model/expenses_request_model.dart';
import 'package:hr_app/features/home_screen/data/model/holiday_model.dart';
import 'package:hr_app/features/home_screen/data/model/holiday_request_model.dart';
import 'package:hr_app/features/home_screen/data/model/news_model.dart';
import 'package:hr_app/features/home_screen/data/model/product_model.dart';
import 'package:hr_app/features/home_screen/data/model/salary_line_model.dart';
import 'package:hr_app/features/home_screen/data/model/salary_model.dart';
import 'package:hr_app/features/home_screen/data/model/status_model.dart';
import '../../../../core/failures/failures.dart';


abstract class HomeRepo {
  Future<Either<Failures, ExpensesModel>> getExpenses();
  Future<Either<Failures, ExpensesRequestModel>> requestExpenses({required String name,required int productId,required String date});
  Future<Either<Failures, HolidayModel>> getHolidays();
  Future<Either<Failures, HolidayRequestModel>> requestHoliday({required String name,required int statusId,required String fromDate,
    required String toDate});
  Future<Either<Failures, StatusModel>> getStatus();
  Future<Either<Failures, NewsModel>> getNews();
  Future<Either<Failures, ProductModel>> getProducts();
  Future<Either<Failures, SalaryModel>> getSalary();
  Future<Either<Failures, SalaryLineModel>> getSalaryLine({required List<int>ids});

  Future<Either<Failures, EmployeeModel>> getEmployee({required int uID});
}
