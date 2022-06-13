import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_app/Data/network/faiure.dart';
import 'package:flutter_mvvm_app/Domain/models/models.dart';
import 'package:flutter_mvvm_app/Domain/repository/repository.dart';
import 'package:flutter_mvvm_app/Domain/requests.dart';
import 'base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,Authentication>{
  final Repository _repository ;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async{
    return await _repository.register(RegisterRequest(input.email, input.password, input.phoneNumber, input.mobileCountyCode, input.profilePicture, input.userName));
  }
}
/*
{
  "user_name":"test",
  "country_mobile_code":"+20",
  "mobile_number":"01011459031",
  "email":"test@gmail.com",
  "password":"123456789",
  "profile_picture":" "
}
*/
class RegisterUseCaseInput{
  String email;
  String password;
  String phoneNumber;
  String mobileCountyCode;
  String profilePicture;
  String userName;

  RegisterUseCaseInput(this.email, this.password,this.mobileCountyCode,this.phoneNumber,this.profilePicture,this.userName);
}