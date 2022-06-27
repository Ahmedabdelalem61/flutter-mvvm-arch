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

  @POST("/customers/register")
  Future<AuthenticationResponse> register(@Field("user_name") String userName,
                                          @Field("country_mobile_code") String countryMobileCode,
                                          @Field("mobile_number") String mobileNumber,
                                          @Field("email") String email,
                                          @Field("password") String password,
                                          @Field("profile_picture") String profilePicture,
                                          );
  
  @GET("/home")
  Future<HomeResponse> getHomeData();

  @GET("/store")
  Future<StoreDetailsResponse> getStoreDetailsData();
}