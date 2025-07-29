import 'package:dartz/dartz.dart';
import 'package:hr_app/features/home_screen/data/model/attend_out_model.dart';
import '../../../../core/failures/failures.dart';
import '../model/attend_model.dart';


abstract class AttendRepo{
  Future<Either<Failures, AttendModel>> checkIn({required String checkInTime});
  Future<Either<Failures, AttendOutModel>> checkOut({required int id,required String checkoutTime});
}