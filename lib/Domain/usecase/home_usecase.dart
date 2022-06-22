import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_app/Data/network/faiure.dart';
import 'package:flutter_mvvm_app/Domain/models/models.dart';
import 'package:flutter_mvvm_app/Domain/repository/repository.dart';
import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject>{
  final Repository _repository ;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async{
    return await _repository.getHomeData();
  }
}
