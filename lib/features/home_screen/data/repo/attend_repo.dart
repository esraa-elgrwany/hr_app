import 'package:dartz/dartz.dart';
import '../../../../core/Failures/Failures.dart';
import '../Model/attend_model.dart';


abstract class AttendRepo{
  Future<Either<Failures, AttendModel>> checkIn(Map<String, dynamic> params);
  Future<Either<Failures, AttendModel>> checkOut(Map<String, dynamic> params);
}