import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/Api_Services/Api-Manager.dart';
import '../../../../core/Failures/Failures.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../auth/data/models/employee_model.dart';
import '../Model/GetTimeOff.dart';
import 'package:hr_app/features/home_screen/data/model/expenses_model.dart';
import 'HomeRepo.dart';

class HomeRepoImpl implements HomeRepo{
  ApiManager apiManager;
  int id = CacheData.getData(key: "userId");
  int employeeId = CacheData.getEmployeeData(key: "employeeId");
  HomeRepoImpl(this.apiManager);
  @override
  Future<Either<Failures, ExpensesModel>> getExpenses() async{
    final Map<String, dynamic> body = {
      "jsonrpc": "2.0",
      "method": "call",
      "params": {
        "service": "object",
        "method": "execute_kw",
        "args": [
          "odoo",
          2,
          "admin",
          "hr.expense",
          "search_read",
          [
            [
              ["employee_id", "=",employeeId]
            ]
          ],
          {
            "fields": ["id", "name", "product_id", "total_amount_currency", "employee_id", "date"],
            "limit": 100
          }
        ]
      },
      "id": 1
    };

   try{
      Response response = await apiManager.postData(
        body: body
      );
      ExpensesModel model = ExpensesModel.fromJson(response.data);
      print("Expenses+++++++++++++++++++++++++++++++${response.data}");
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, GetTimeOff>> getTimeOff() async{
    try {
      Response response = await apiManager.getData(
      );
      GetTimeOff model = GetTimeOff.fromJson(response.data);
      print("Time Off+++++++++++++++++++++++++++++++${response.data}");
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failures, EmployeeModel>> getEmployee() async {
    if (id == null) {
      print("🚨 Error: userId is null");
      return Left(ServerFailure("Invalid userId"));
    }

    print("Fetching employee for userId: $id");

    final Map<String, dynamic> body = {
      "jsonrpc": "2.0",
      "method": "call",
      "params": {
        "service": "object",
        "method": "execute_kw",
        "args": [
          "odoo",
          2,
          "admin",
          "res.users",
          "search_read",
          [
            [
              ["id", "=", id]
            ]
          ],
          {
            "fields": ["id", "name", "employee_ids"],
            "limit": 1
          }
        ]
      },
      "id": 1
    };

    try {
      print("API Request Body: $body");

      final response = await apiManager.postData(body: body);

      print("API Response: ${response.data}");

      if (response.data == null || !response.data.containsKey('result')) {
        return Left(ServerFailure("Invalid API response format"));
      }

      EmployeeModel employeeModel = EmployeeModel.fromJson(response.data);

      if (response.statusCode == 200 && employeeModel.result != null && employeeModel.result!.isNotEmpty) {
        print("✅ Employee data fetched successfully");
        return Right(employeeModel);
      } else {
        print("⚠️ Empty result from API");
        return Left(ServerFailure("No employee data found"));
      }
    } catch (e) {
      print("❌ Network Error: $e");
      return Left(ServerFailure("Network Error: $e"));
    }
  }
}