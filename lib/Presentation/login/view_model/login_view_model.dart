import 'dart:async';

import 'package:flutter_mvvm_app/Presentation/base/baseviewmodel.dart';

import '../../../Domain/usecase/login_usecase.dart';
import '../../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  var loginObject = LoginObject("", "");
 // final LoginUseCase _loginUseCase ;

  //LoginViewModel(this._loginUseCase);
  LoginViewModel();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  @override
  void dispose() {
    _passwordStreamController.close();
    _userNameStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUerName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputsValid.add(null);
  }

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  bool _isValid(String val) {
    return val.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isValid(loginObject.password) && _isValid(loginObject.userName);
  }

  @override
  Stream<bool> get isPasswordValid =>
      _passwordStreamController.stream.map((password) => _isValid(password));

  @override
  Stream<bool> get isUserNameValid =>
      _passwordStreamController.stream.map((userName) => _isValid(userName));

  @override
  login() async {
    // (await _loginUseCase.execute(
    //         LoginUseCaseInput(loginObject.userName, loginObject.password)))
    //     .fold((failure) => {print(failure.message)},
    //         (data) => {print(data.customer?.name)});
  }
}

abstract class LoginViewModelInput {
  login();

  setUerName(String userName);

  setPassword(String password);

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get isUserNameValid;

  Stream<bool> get isPasswordValid;

  Stream<bool> get outAreAllInputsValid;
}
