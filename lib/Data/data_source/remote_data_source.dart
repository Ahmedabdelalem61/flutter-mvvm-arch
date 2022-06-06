import 'package:flutter_mvvm_app/Data/network/app_api.dart';
import 'package:flutter_mvvm_app/Data/responses/responses.dart';
import 'package:flutter_mvvm_app/Domain/requests.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);

}

class RemoteDataSourceImp implements RemoteDataSource{

  final AppServicesClient _appServicesClient;
  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest)async {
   return await _appServicesClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email)async {
    return await _appServicesClient.forgotPassword(email);
  }
}