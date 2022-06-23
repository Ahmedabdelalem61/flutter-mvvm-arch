import 'package:flutter/cupertino.dart';
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

