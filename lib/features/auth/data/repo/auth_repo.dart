import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../models/login_model.dart';
abstract class AuthRepo{
  Future<Either<Failures, LoginModel>> login(String userName, String password);

}