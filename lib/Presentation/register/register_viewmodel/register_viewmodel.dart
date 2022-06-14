import 'dart:async';

import 'package:analyzer/file_system/file_system.dart';
import 'package:flutter_mvvm_app/App/functions.dart';
import 'package:flutter_mvvm_app/Domain/usecase/register_usecase.dart';
import 'package:flutter_mvvm_app/Presentation/base/baseviewmodel.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_rendrer.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';

import '../../common/freezed_data_classes.dart';
import '../../common/state_rendrer/state_renderer_imp.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput , RegisterViewModelOutput{
  
  
  
  
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);
  
  StreamController passwordStreamControllerValid = StreamController<bool>.broadcast();
  StreamController emailStreamControllerValid = StreamController<bool>.broadcast();
  StreamController userNameStreamControllerValid = StreamController<bool>.broadcast();
  StreamController phoneNumberStreamControllerValid = StreamController<bool>.broadcast();
  StreamController profilePictureStreamControllerValid = StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController = StreamController<void>.broadcast();

  RegisterObject registerObject = RegisterObject("", "", "", "", "", "");


  
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
    areAllInputsValidStreamController.close();
    super.dispose();
  }

   @override
  Sink get inputAllInputsValid => areAllInputsValidStreamController.sink;


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


  @override
  setUserName(String userName) {
    if (_isUserNameValid(userName)) {
      //  update register view object
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset username value in register view object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

 register() async {
    stateInput.add(
        LoadingState(stateType: RendrerStateType.popupLoadingState,title: 'loading..',message: 'please wait...'));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerObject.userName,
            registerObject.mobileCountyCode,
            registerObject.phoneNumber,
            registerObject.email,
            registerObject.password,
            registerObject.profilePicture)))
        .fold(
            (failure) => {
                  // left -> failure
                  stateInput.add(ErrorState(stateRendererType: RendrerStateType.popupErorrState, message: failure.message))
                }, (data) {
      // right -> data (success)
      // content
      stateInput.add(ContentState());
      // navigate to main screen
      // isUserLoggedInSuccessfullyStreamController.add(true);
    });
 }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      //  update register view object
      registerObject = registerObject.copyWith(mobileCountyCode: countryCode);
    } else {
      // reset code value in register view object
      registerObject = registerObject.copyWith(mobileCountyCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    if (isEmailValid(email)) {
      //  update register view object
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    if (_isPhoneNumberValid(mobileNumber)) {
      //  update register view object
      registerObject = registerObject.copyWith(phoneNumber: mobileNumber);
    } else {
      // reset mobileNumber value in register view object
      registerObject = registerObject.copyWith(phoneNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    if (_isPasswordValid(password)) {
      //  update register view object
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset password value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    if (profilePicture.path.isNotEmpty) {
      //  update register view object
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profilePicture value in register view object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
  validate();
  }

  

  @override
  Stream<bool> get outputAreAllInputsValid =>
      areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

    bool _areAllInputsValid() {
    return registerObject.mobileCountyCode.isNotEmpty &&
        registerObject.phoneNumber.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }

}


abstract class RegisterViewModelInput{
  Sink get passwordStreamControllerValidInput;
  Sink get userNameStreamControllerValidInput;
  Sink get phoneNumberStreamControllerValidInput;
  Sink get emailStreamControllerValidInput;
  Sink get profilePicStreamControllerValidInput;
  Sink get inputAllInputsValid;


  register();
  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
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

  
  Stream<bool> get outputAreAllInputsValid;

  Stream<File> get profilePictureStreamControllerValidOutput;


}