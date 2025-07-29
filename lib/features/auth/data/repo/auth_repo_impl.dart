import 'package:dartz/dartz.dart';
import '../../../../core/api_services/api-manager.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../../core/failures/failures.dart';
import '../models/login_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  ApiManager apiManager;

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
        "args": ["dhr-new-main-21965090", user, password],
      },
      "id": 1,
    };

    try {
      final response =await apiManager.postData(
        body:body,
      );
      LoginModel user=LoginModel.fromJson(response.data);
      print("Login data result$user");
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
