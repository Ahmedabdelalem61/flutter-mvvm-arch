import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;

  CustomerResponse(this.id, this.name, this.numOfNotifications);

  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
  ContactsResponse(this.phone, this.email, this.link);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer, this.contacts);
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;
  ForgotPasswordResponse(this.support);
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  ServiceResponse(this.id, this.title, this.image);
  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$ServiceResponseToJson(this);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  BannerResponse(this.id, this.title, this.image);
  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$BannerResponseToJson(this);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  StoreResponse(this.id, this.title, this.image);
  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$StoreResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "services")
  List<ServiceResponse> servicesResponse;
  @JsonKey(name: "banners")
  List<BannerResponse> bannersResponse;
  @JsonKey(name: "stores")
  List<StoreResponse> storesResponse;

  HomeDataResponse(
      this.bannersResponse, this.servicesResponse, this.storesResponse);
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: "data")
  HomeDataResponse data;

  HomeResponse(
      this.data);
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
  Map<String, dynamic> toMap(Map<String, dynamic> json) =>
      _$HomeResponseToJson(this);
}
@JsonSerializable()
class StoreDetailsResponse with BaseResponse{
@JsonKey(name: 'image')
String image; 
@JsonKey(name: 'title')
String title;
@JsonKey(name: 'details')
String details;
@JsonKey(name: 'services')
String services;
@JsonKey(name: 'about')
String about;
StoreDetailsResponse(this.image,this.details,this.title,this.services,this.about);
factory StoreDetailsResponse.fromJson(Map<String,dynamic> json) => _$StoreDetailsResponseFromJson(json);
Map<String,dynamic> toJson(Map<String,dynamic> json) => _$StoreDetailsResponseToJson(this);
}
/*
{
  "status": 0,
  "message": "Success",
  "image":"https://images.unsplash.com/photo-1562280963-8a5475740a10?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
  "id":1,
  "title":"Amazing Stores",
  "details":"Details Lorem Ipsum is simply dummy text of the printing andtypesetting industry. Lorem Ipsum has been the industry’s standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambledit to make a type specimen book. It has survived not only five centuries, but also theleap into electronic typesetting, remaining essentially unchanged. It was popularisedin the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,and more recently with desktop publishing software like Aldus PageMaker includingversions of Lorem Ipsum",
  "services":"Services Store Lorem Ipsum is simply dummy text of the printing andtypesetting industry. Lorem Ipsum has been the industry’s standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambledit to make a type specimen book. It has survived not only five centuries, but also theleap into electronic typesetting, remaining essentially unchanged. It was popularisedin the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,and more recently with desktop publishing software like Aldus PageMaker includingversions of Lorem Ipsum",
  "about":"About Store Lorem Ipsum is simply dummy text of the printing andtypesetting industry. Lorem Ipsum has been the industry’s standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambledit to make a type specimen book. It has survived not only five centuries, but also theleap into electronic typesetting, remaining essentially unchanged. It was popularisedin the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,and more recently with desktop publishing software like Aldus PageMaker includingversions of Lorem Ipsum"
}
*/
