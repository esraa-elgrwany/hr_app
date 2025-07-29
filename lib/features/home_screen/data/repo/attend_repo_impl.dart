import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hr_app/core/cache/shared_preferences.dart';
import 'package:hr_app/features/home_screen/data/model/attend_out_model.dart';
import '../../../../core/api_services/api-manager.dart';
import '../../../../core/failures/failures.dart';
import '../model/attend_model.dart';
import 'attend_repo.dart';

class AttendRepoImpl implements AttendRepo{
  ApiManager apiManager;

  AttendRepoImpl(this.apiManager);
  @override
  Future<Either<Failures, AttendModel>> checkIn({required String checkInTime}) async{
    try {
      final body = {
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": [
            "dhr-new-main-21965090",
            2,
            CacheData.getData(key: "password"),
            "hr.attendance",
            "create",
            [
              {
                "employee_id": CacheData.getData(key: "employeeId"),
                "check_in": checkInTime
              }
            ]
          ]
        },
        "id": 1
      };

       Response response = await apiManager.postData(body: body);
      AttendModel model = AttendModel.fromJson(response.data);
      if (response.statusCode == 200) {
        print("CheckIn data Success: $model");
        return Right(model);
      } else {
        return Left(ServerFailure('Check-in failed: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(ServerFailure('Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failures, AttendOutModel>> checkOut({required int id,required String checkoutTime}) async{
    try {
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
            "hr.attendance",
            "write",
            [
              [id],
              {
                "check_out": checkoutTime
              }
            ]
          ]
        },
        "id": 2
      };
      final response = await apiManager.postData(body: body);
      AttendOutModel model = AttendOutModel.fromJson(response.data);
      if (response.statusCode == 200) {
        print("CheckOut data Success: $model");
        return Right(model);
      } else {
        return Left(ServerFailure('Check-out failed: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(ServerFailure('Error during check-out: $e'));
    }
  }

}