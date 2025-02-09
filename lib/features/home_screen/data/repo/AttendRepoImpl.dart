import 'package:dartz/dartz.dart';

import '../../../../core/Api_Services/Api-Manager.dart';
import '../../../../core/Failures/Failures.dart';
import '../Model/AttendModel.dart';
import 'attendRepo.dart';

class AttendRepoImpl implements AttendRepo{
  ApiManager apiManager;

  AttendRepoImpl(this.apiManager);
  @override
  Future<Either<Failures, AttendModel>> checkIn(Map<String, dynamic> params) async{
    try {
      final body = {
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": ["odoo", 2, "admin", "hr.attendance", "create", [params]]
        },
        "id": 1
      };

      final response = await apiManager.postData(body: body);

      if (response.statusCode == 200) {
        AttendModel model = AttendModel.fromJson(response.data);
        return Right(model);
      } else {
        return Left(ServerFailure('Check-in failed: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(ServerFailure('Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failures, AttendModel>> checkOut(Map<String, dynamic> params) async{
    try {
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
            "hr.attendance",
            "write",
            [
              [476],
              params,
            ]
          ]
        },
        "id": 2
      };
      final response = await apiManager.postData(body: body);
      if (response.statusCode == 200) {
        AttendModel model = AttendModel.fromJson(response.data);
        return Right(model);
      } else {
        return Left(ServerFailure('Check-out failed: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(ServerFailure('Error during check-out: $e'));
    }
  }

}