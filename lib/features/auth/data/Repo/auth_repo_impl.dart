import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hr_app/features/auth/data/models/employee_model.dart';
import '../../../../core/Api_Services/Api-Manager.dart';
import '../../../../core/Failures/Failures.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../models/login_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  ApiManager apiManager;
  int? id = CacheData.getData(key: "userId");

  AuthRepoImpl(this.apiManager);

  @override
  Future<Either<Failures, LoginModel>> login(
       String user, String password) async {
    final Map<String, dynamic> body = {
      "jsonrpc": "2.0",
      "method": "call",
      "params": {
        "service": "common",
        "method": "login",
        "args": ["odoo", user, password],
      },
      "id": 1,
    };

    try {
      final response =await apiManager.postData(
        body:body,
      );
      LoginModel user=LoginModel.fromJson(response.data);
      CacheData.saveId(data: user.result, key:"userId");
      if (response.statusCode == 200) {
        return Right(user);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Network Error: $e"));
    }
  }




}
