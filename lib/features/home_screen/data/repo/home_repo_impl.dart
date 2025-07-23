import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hr_app/core/cache/shared_preferences.dart';
import 'package:hr_app/features/home_screen/data/model/employee_model.dart';
import 'package:hr_app/features/home_screen/data/model/expenses_model.dart';
import 'package:hr_app/features/home_screen/data/model/holiday_model.dart';
import 'package:hr_app/features/home_screen/data/model/holiday_request_model.dart';
import 'package:hr_app/features/home_screen/data/model/salary_model.dart';
import 'package:hr_app/features/home_screen/data/model/status_model.dart';
import '../../../../core/api_services/api-manager.dart';
import '../../../../core/failures/failures.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  ApiManager apiManager;

  HomeRepoImpl(this.apiManager);

  @override
  Future<Either<Failures, ExpensesModel>> getExpenses() async {
    final Map<String, dynamic> body = {
      "jsonrpc": "2.0",
      "method": "call",
      "params": {
        "service": "object",
        "method": "execute_kw",
        "args": [
          "dhr-new-main-21965090",
          2,
          CacheData.getData(key: "password"),
          "hr.expense",
          "search_read",
          [
            [
              [
                "employee_id",
                "=",
                CacheData.getEmployeeData(key: "employeeId") ?? 0
              ]
            ]
          ],
          {
            "fields": [
              "id",
              "name",
              "product_id",
              "total_amount_currency",
              "employee_id",
              "date"
            ],
            "limit": 100
          }
        ]
      },
      "id": 1
    };

    try {
      Response response = await apiManager.postData(body: body);
      ExpensesModel model = ExpensesModel.fromJson(response.data);
      print("Expenses+++++++++++++++++++++++++++++++${response.data}");
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, EmployeeModel>> getEmployee(
      {required int uID}) async {
    final Map<String, dynamic> body = {
      "jsonrpc": "2.0",
      "method": "call",
      "params": {
        "service": "object",
        "method": "execute_kw",
        "args": [
          "dhr-new-main-21965090",
          2,
          CacheData.getData(key: "password"),
          "res.users",
          "search_read",
          [
            [
              ["id", "=", uID]
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

      final response = await apiManager.postData(body: body);

      print("API Response: ${response.data}");

      if (response.data == null || !response.data.containsKey('result')) {
        return Left(ServerFailure("Invalid API response format"));
      }

      EmployeeModel employeeModel = EmployeeModel.fromJson(response.data);

      if (response.statusCode == 200 &&
          employeeModel.result != null &&
          employeeModel.result!.isNotEmpty) {
        print(" Employee data fetched successfully");
        return Right(employeeModel);
      } else {
        print("Empty result from API");
        return Left(ServerFailure("No employee data found"));
      }
    } catch (e) {
      print("Network Error: $e");
      return Left(ServerFailure("Network Error: $e"));
    }
  }

  @override
  Future<Either<Failures, HolidayModel>> getHolidays() async {
    Map<String, dynamic> requestBody = {
      "jsonrpc": "2.0",
      "method": "call",
      "params": {
        "service": "object",
        "method": "execute_kw",
        "args": [
          "dhr-new-main-21965090",
          2,
    CacheData.getData(key: "password"),
          "hr.leave",
          "search_read",
          [
            [
              ["user_id", "=", CacheData.getData(key: "userId") ?? 0]
            ]
          ],
          {
            "fields": [
              "id",
              "name",
              "holiday_status_id",
              "request_date_from",
              "request_date_to",
              "state"
            ],
            "limit": 100
          }
        ]
      },
      "id": 1
    };

    try {
      Response response = await apiManager.postData(body: requestBody);
      HolidayModel model = HolidayModel.fromJson(response.data);
      print("Holidays+++++++++++++++++++++++++++++++${response.data}");
      if (response.statusCode == 200) {
        print("Holidays Success: $model");
        return Right(model);
      } else {
        print("Holidays Error: ${response.statusCode}");
        return Left(ServerFailure("some thing went wrong"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

 @override
  Future<Either<Failures, SalaryModel>> getSalarySlip() async{
   final Map<String, dynamic> body = {
     "jsonrpc": "2.0",
     "method": "call",
     "params": {
       "service": "object",
       "method": "execute_kw",
       "args": [
         "dhr-new-main-21965090",
         2,
         CacheData.getData(key: "password"),
         "hr.payslip",
         "search_read",
         [
           [["employee_id", "=",CacheData.getEmployeeData(key: "employeeId") ?? 0]]  // Filter by employee_id
         ],
         {
           "fields": ["id", "name", "date_from", "date_to", "state", "employee_id", "line_ids"],
           "order": "date_from desc",
           "limit": 100
         }
       ]
     },
     "id": 1
   };

   try {

     final response = await apiManager.postData(body: body);

     print("API Response: ${response.data}");

     if (response.data == null || !response.data.containsKey('result')) {
       return Left(ServerFailure("Invalid API response format"));
     }

    SalaryModel salaryModel =SalaryModel.fromJson(response.data);

     if (response.statusCode == 200 &&
        salaryModel.result != null &&
         salaryModel.result!.isNotEmpty) {
       print(" salarydata fetched successfully");
       return Right(salaryModel);
     } else {
       print("Empty result from API");
       return Left(ServerFailure("No salary data found"));
     }
   } catch (e) {
     print("Network Error: $e");
     return Left(ServerFailure("Network Error: $e"));
   }
 }

  @override
  Future<Either<Failures, HolidayRequestModel>> requestHoliday({required String name,required int statusId,required String fromDate,
    required String toDate}) async{
    Map<String, dynamic> requestBody = {
      "jsonrpc": "2.0",
      "method": "call",
      "params": {
        "service": "object",
        "method": "execute_kw",
        "args": [
          "dhr-new-main-21965090",
          2,
          CacheData.getData(key: "password"),
          "hr.leave",
          "create",
          [
            {
              "employee_id":CacheData.getEmployeeData(key: "employeeId") ?? 0,
              "holiday_status_id": statusId,
              "request_date_from": fromDate,
              "request_date_to": toDate,
              "name": name


            }
          ]
        ]
      },
      "id": 1
    };

    try {
      Response response = await apiManager.postData(body: requestBody);
      HolidayRequestModel model = HolidayRequestModel.fromJson(response.data);
      print("HolidayRequest +++++++++++++++++++++++++++++++${response.data}");
      if (response.statusCode == 200) {
        print("HolidayRequest Success: $model");
        return Right(model);
      } else {
        print("HolidayRequest Error: ${response.statusCode}");
        return Left(ServerFailure("some thing went wrong"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, StatusModel>> getStatus() async{
    final Map<String, dynamic> body = {
      "jsonrpc": "2.0",
      "method": "call",
      "params": {
        "service": "object",
        "method": "execute_kw",
        "args": [
          "dhr-new-main-21965090",
          2,
          CacheData.getData(key: "password"),
          "hr.leave.type",
          "search_read",
          [[]],
          {
            "fields": ["id", "name"],
            "limit": 50
          }
        ]
      },
      "id": 1
    };

    try {
      Response response = await apiManager.postData(body: body);
      StatusModel model = StatusModel.fromJson(response.data);
      print("status data+++++++++++++++++++++++++++++++${response.data}");
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
