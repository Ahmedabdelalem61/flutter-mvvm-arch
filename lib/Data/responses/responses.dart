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
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer,this.contacts);
  factory AuthenticationResponse.fromJson(Map<String,dynamic>json)=>_$AuthenticationResponseFromJson(json);
  Map<String,dynamic> toMap(Map<String,dynamic> json) => _$AuthenticationResponseToJson(this);
}
@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse{
  @JsonKey(name: "support")
  String? support;
  ForgotPasswordResponse(this.support);
  factory ForgotPasswordResponse.fromJson(Map<String,dynamic>json)=>_$ForgotPasswordResponseFromJson(json);
  Map<String,dynamic> toMap(Map<String,dynamic> json) => _$ForgotPasswordResponseToJson(this);
}