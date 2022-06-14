import 'dart:async';

import 'package:analyzer/file_system/file_system.dart';
import 'package:flutter_mvvm_app/App/functions.dart';
import 'package:flutter_mvvm_app/Domain/usecase/register_usecase.dart';
import 'package:flutter_mvvm_app/Presentation/base/baseviewmodel.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput , RegisterViewModelOutput{
  
  
  
  
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);
  
  StreamController passwordStreamControllerValid = StreamController<bool>.broadcast();
  StreamController emailStreamControllerValid = StreamController<bool>.broadcast();
  StreamController userNameStreamControllerValid = StreamController<bool>.broadcast();
  StreamController phoneNumberStreamControllerValid = StreamController<bool>.broadcast();
  StreamController profilePictureStreamControllerValid = StreamController<File>.broadcast();
  StreamController allStreamControllersValid = StreamController<void>.broadcast();
  
  
  
  @override
  void start() {
    // TODO: implement start
  }
  
  @override
  void dispose() {
    passwordStreamControllerValid.close();
    emailStreamControllerValid.close();
    userNameStreamControllerValid.close();
    phoneNumberStreamControllerValid.close();
    profilePictureStreamControllerValid.close();
    allStreamControllersValid.close();
    super.dispose();
  }

  @override
  Sink get emailStreamControllerValidInput => emailStreamControllerValid.sink;

  @override
  Sink get passwordStreamControllerValidInput => passwordStreamControllerValid.sink;

  @override
  Sink get profilePicStreamControllerValidInput => profilePictureStreamControllerValid.sink;

  @override
  Sink get phoneNumberStreamControllerValidInput => phoneNumberStreamControllerValid.sink;

  @override
  Sink get userNameStreamControllerValidInput => userNameStreamControllerValid.sink;

  // output streams

  @override
  Stream<String?> get userNameErrorStreamControllerValidOutput =>  userNameStreamControllerValidOutput.map((userName) => userName?null:AppStrings.userNameInvalid);
  
  @override
  Stream<bool> get userNameStreamControllerValidOutput => userNameStreamControllerValid.stream.map((userName) => 
  _isUserNameValid(userName));

  bool _isUserNameValid(String userName){
    return userName.length >= 8;
  }

  @override
  Stream<bool> get emailStreamControllerValidOutput => emailStreamControllerValid.stream.map((email) => isEmailValid(email)); 

  @override
  Stream<String?> get emailErrorStreamControllerValidOutput => emailStreamControllerValidOutput.map((email) => email?null:AppStrings.emailInvalid);

  @override
  Stream<bool> get allValidOutput => throw UnimplementedError();

  @override
  Stream<bool> get passwordStreamControllerValidOutput => passwordStreamControllerValid.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get passwordErrorStreamControllerValidOutput => passwordStreamControllerValidOutput.map((password) => password?null:AppStrings.passwordInvalid);



  bool _isPasswordValid(String password){
    return password.length >= 6;
  }
  

  @override
  Stream<bool> get phoneNumberStreamControllerValidOutput => phoneNumberStreamControllerValid.stream.map((phoneNumber) => _isPhoneNumberValid(phoneNumber));
   
   @override
  Stream<String?> get phoneNumberErrorStreamControllerValidOutput => phoneNumberStreamControllerValidOutput.map((phone) => phone?null: AppStrings.phoneNumberInvalid);

   bool _isPhoneNumberValid(String phoneNumber){
    return phoneNumber.length >= 10;
  }

  @override
  Stream<File> get profilePictureStreamControllerValidOutput => profilePictureStreamControllerValid.stream.map((file) => file);




 
}

abstract class RegisterViewModelInput{
  Sink get passwordStreamControllerValidInput;
  Sink get userNameStreamControllerValidInput;
  Sink get phoneNumberStreamControllerValidInput;
  Sink get emailStreamControllerValidInput;
  Sink get profilePicStreamControllerValidInput;
}

abstract class RegisterViewModelOutput{
  Stream<bool> get passwordStreamControllerValidOutput;
  Stream<String?> get passwordErrorStreamControllerValidOutput;

  Stream<bool> get userNameStreamControllerValidOutput;
  Stream<String?> get userNameErrorStreamControllerValidOutput;


  Stream<bool> get phoneNumberStreamControllerValidOutput;
  Stream<String?> get phoneNumberErrorStreamControllerValidOutput;

  
  Stream<bool> get emailStreamControllerValidOutput;
  Stream<String?> get emailErrorStreamControllerValidOutput;

  
  Stream<bool> get allValidOutput;

  Stream<File> get profilePictureStreamControllerValidOutput;


}