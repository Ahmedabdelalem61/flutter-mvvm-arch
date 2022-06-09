import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_app/App/dependency_injection.dart';
import 'package:flutter_mvvm_app/Domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_mvvm_app/Presentation/base/baseviewmodel.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_renderer_imp.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_rendrer.dart';
import '../../../App/functions.dart';

class ForgotPasswordViewModel extends BaseViewModel with ForgotPasswordViewModelInput ,  ForgotPasswordViewModelOutput{
  
  String email = '';
  final StreamController<String> emailStreamController = StreamController<String>.broadcast();
  //todo make initRegister dependency injection
  late ForgotPasswordUseCase _forgotPasswordUseCase = dIinstance();
  ForgotPasswordViewModel(this._forgotPasswordUseCase);


  @override
  void start() {
    // adding content state here means that the view stream will view the initial view that impelemnted there
    stateInput.add(ContentState());
  }
  @override
  void dispose() {
    emailStreamController.close();
    super.dispose();
  }

  @override
  forgotPassword() async {
    //showing loading state
    stateInput.add(LoadingState(stateType: RendrerStateType.popupLoadingState,message: 'wait for seconds',title: 'loading'));
    (await _forgotPasswordUseCase.execute(email)).fold((failure){
      //showing error pop up with message
      stateInput.add(ErrorState(stateRendererType: RendrerStateType.popupErorrState, message: failure.message,));
    },(data){
      stateInput.add(SuccessState(message: data, stateType: RendrerStateType.popupSuccessState,title: 'success'));
    });
  }



  @override
  void setEmail(String email) {
    //the email will come from the textController
    this.email = email;
    emailStreamController.add(email);
  }

  @override
  Stream<bool> get OutputIsEmailValid => emailStreamController.stream.map((email) => validate(email));

  @override
  Sink get inputIsEmailValid => emailStreamController.sink;

  bool validate(String email){
    return isEmailValid(email);
  }
}
abstract class ForgotPasswordViewModelInput{
  Sink get inputIsEmailValid;
  forgotPassword();
  void setEmail(String email);
}

abstract class ForgotPasswordViewModelOutput{
  Stream<bool> get  OutputIsEmailValid;
}
