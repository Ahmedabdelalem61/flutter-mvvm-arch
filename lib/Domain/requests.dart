class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
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

class RegisterRequest {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterRequest(this.email, this.password, this.mobileNumber,
      this.countryMobileCode, this.profilePicture, this.userName);
}
