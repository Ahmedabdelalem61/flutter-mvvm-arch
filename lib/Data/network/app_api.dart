import 'package:dio/dio.dart';
import 'package:flutter_mvvm_app/App/constants.dart';
import 'package:flutter_mvvm_app/Data/responses/responses.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient{
  // _AppServicesClient created using retrofit
  factory AppServicesClient(Dio dio,{String baseUrl})= _AppServicesClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(@Field("email") String email,@Field("password") String password);
  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);
}