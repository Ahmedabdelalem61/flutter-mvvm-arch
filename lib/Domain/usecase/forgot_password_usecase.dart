import 'package:flutter_mvvm_app/Data/network/faiure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_app/Domain/repository/repository.dart';
import 'package:flutter_mvvm_app/Domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase extends BaseUseCase<String,String>{
  ForgotPasswordUseCase(this.repository);
  Repository repository;
  @override
  Future<Either<Failure, String>> execute(String input)async {
    return await repository.forgotPassword(input);
  }
}