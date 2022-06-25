import 'package:flutter_mvvm_app/Data/network/app_api.dart';
import 'package:flutter_mvvm_app/Data/responses/responses.dart';
import 'package:flutter_mvvm_app/Domain/requests.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetailsData();

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

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest)async {
   return await _appServicesClient.register(registerRequest.userName, registerRequest.countryMobileCode, registerRequest.mobileNumber,
    registerRequest.email, registerRequest.password, registerRequest.profilePicture);
  }
  
  @override
  Future<HomeResponse> getHomeData()async {
    return await _appServicesClient.getHomeData();
  }
  
  @override
  Future<StoreDetailsResponse> getStoreDetailsData()async {
    return await _appServicesClient.getStoreDetailsData();
  }
}