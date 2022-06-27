import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_app/Data/network/faiure.dart';
import 'package:flutter_mvvm_app/Domain/models/models.dart';
import 'package:flutter_mvvm_app/Domain/repository/repository.dart';
import 'base_usecase.dart';

class StoreDetailsUSeCase implements BaseUseCase<void,StoreDetails>{
  final Repository _repository ;
  StoreDetailsUSeCase(this._repository);
  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async{
    return await _repository.getStoreDetailsData();
  }
}
