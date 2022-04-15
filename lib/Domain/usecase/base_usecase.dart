import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_app/Data/network/faiure.dart';

abstract class BaseUseCase<In,Out>{
  Future<Either<Failure,Out>>  execute(In input);
}