import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mvvm_app/App/functions.dart';
import 'package:flutter_mvvm_app/Domain/usecase/register_usecase.dart';
import 'package:flutter_mvvm_app/Presentation/base/baseviewmodel.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_rendrer.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_rendrer/state_renderer_imp.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput , RegisterViewModelOutput{
  
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);
  
  StreamController passwordStreamControllerValid = StreamController<String>.broadcast();
  StreamController emailStreamControllerValid = StreamController<String>.broadcast();
  StreamController userNameStreamControllerValid = StreamController<String>.broadcast();
  StreamController phoneNumberStreamControllerValid = StreamController<String>.broadcast();
  StreamController profilePictureStreamController = StreamController<XFile>.broadcast();
  StreamController areAllInputsValidStreamController = StreamController<void>.broadcast();
  StreamController isUserRegisteredStreamController = StreamController<bool>.broadcast();

  RegisterObject registerObject = RegisterObject("", "", "", "", "", "");


  
  @override
  void start() {
    // start here for things like calling api or adding specific view (rendering states)
    stateInput.add(ContentState());
  }
  
  @override
  void dispose() {
    passwordStreamControllerValid.close();
    emailStreamControllerValid.close();
    userNameStreamControllerValid.close();
    phoneNumberStreamControllerValid.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
    isUserRegisteredStreamController.close();
    super.dispose();
  }

   @override
  Sink get inputAllInputs => areAllInputsValidStreamController.sink;


  @override
  Sink get inputemail => emailStreamControllerValid.sink;

  @override
  Sink get inputPassword => passwordStreamControllerValid.sink;

  @override
  Sink get inputProfilePic => profilePictureStreamController.sink;

  @override
  Sink get inputPhoneNumber=> phoneNumberStreamControllerValid.sink;

  @override
  Sink get inputUserName => userNameStreamControllerValid.sink;

  // output streams

  @override
  Stream<String?> get outputUserNameErrorStreamController =>  outputUserNameStreamControllerValid.map((userName) => userName?null:AppStrings.userNameInvalid.tr());
  
  @override
  Stream<bool> get outputUserNameStreamControllerValid => userNameStreamControllerValid.stream.map((userName) => 
  _isUserNameValid(userName));

  bool _isUserNameValid(String userName){
    return userName.length >= 8;
  }

  @override
  Stream<bool> get outputEmailStreamControllerValid => emailStreamControllerValid.stream.map((email) => isEmailValid(email)); 

  @override
  Stream<String?> get outPutEmailErrorStreamController => outputEmailStreamControllerValid.map((email) => email?null:AppStrings.emailInvalid.tr());


  @override
  Stream<bool> get outputPasswordStreamControllerValid => passwordStreamControllerValid.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputPasswordErrorStreamController => outputPasswordStreamControllerValid.map((password) => password?null:AppStrings.passwordInvalid.tr());



  bool _isPasswordValid(String password){
    return password.length >= 6;
  }
  

  @override
  Stream<bool> get outputPhoneNumberStreamControllerValid => phoneNumberStreamControllerValid.stream.map((phoneNumber) => _isPhoneNumberValid(phoneNumber));
   
   @override
  Stream<String?> get outputPhoneNumberErrorStreamController => outputPhoneNumberStreamControllerValid.map((phone) => phone?null: AppStrings.phoneNumberInvalid.tr());

   bool _isPhoneNumberValid(String phoneNumber){
    return phoneNumber.length >= 10;
  }

  @override
  Stream<XFile> get outputprofilePictureStreamController => profilePictureStreamController.stream.map((file) => file);


  @override
  setUserName(String userName) {
    print(userName);
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      //  update register view object
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset username value in register view object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

 @override
 register() async {
    stateInput.add(
        LoadingState(stateType: RendrerStateType.popupLoadingState,title: 'loading..',message: 'please wait...'));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerObject.email,
            registerObject.password,
            registerObject.mobileCountyCode,
            registerObject.phoneNumber,
            registerObject.profilePicture,
            registerObject.userName)))
        .fold(
            (failure) => {
                  // left -> failure
                  stateInput.add(ErrorState(stateRendererType: RendrerStateType.popupErorrState, message: failure.message))
                }, (data) {
      // right -> data (success)
      // content
      stateInput.add(SuccessState(title: AppStrings.success.tr(), message: AppStrings.registeredSucceefully.tr(), stateType: RendrerStateType.popupSuccessState));
      isUserRegisteredStreamController.add(true);
      //stateInput.add(ContentState());
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
    inputemail.add(email);
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
    inputPhoneNumber.add(mobileNumber);
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
    inputPassword.add(password);
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
  setProfilePicture(XFile profilePicture) {
    inputProfilePic.add(profilePicture);
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
    // for learning purpose incase you forked this repo or used this code i will write alot of comment :)
    // we validate by sending empty data to the allvalidstreamController and checking it's stream if it's valid or not 
    inputAllInputs.add(null);
  }

}


abstract class RegisterViewModelInput{
  Sink get inputPassword;
  Sink get inputUserName;
  Sink get inputPhoneNumber;
  Sink get inputemail;
  Sink get inputProfilePic;
  Sink get inputAllInputs;


  register();
  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(XFile profilePicture);
}

abstract class RegisterViewModelOutput{
  Stream<bool> get outputPasswordStreamControllerValid;
  Stream<String?> get outputPasswordErrorStreamController;//nullable because of if it's val is null we not be error state on the view

  Stream<bool> get outputUserNameStreamControllerValid;
  Stream<String?> get outputUserNameErrorStreamController;


  Stream<bool> get outputPhoneNumberStreamControllerValid;
  Stream<String?> get outputPhoneNumberErrorStreamController;

  
  Stream<bool> get outputEmailStreamControllerValid;
  Stream<String?> get outPutEmailErrorStreamController;

  
  Stream<bool> get outputAreAllInputsValid;

  Stream<XFile> get outputprofilePictureStreamController;


}