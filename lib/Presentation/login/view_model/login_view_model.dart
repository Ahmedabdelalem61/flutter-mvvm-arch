import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mvvm_app/App/app_prefs.dart';
import 'package:flutter_mvvm_app/App/dependency_injection.dart';
import 'package:flutter_mvvm_app/Presentation/base/baseviewmodel.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_renderer_imp.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_rendrer.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';
import '../../../Domain/usecase/login_usecase.dart';
import '../../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController<bool> isUserLoggedinSuccessfullyStreamController =
      StreamController<bool>();

  final AppPreferences _appPreferences = dIinstance<AppPreferences>();

  @override
  void dispose() {
    super.dispose();
    _passwordStreamController.close();
    _userNameStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    stateInput.add(ContentState());
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
      _userNameStreamController.stream.map((userName) => _isValid(userName));

  @override
  login() async {
    stateInput.add(LoadingState(
      stateType: RendrerStateType.popupLoadingState,
      message: AppStrings.loadingMessage.tr(),
      title: AppStrings.loading.tr()
    ));
    
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure)  {
                 stateInput.add(ErrorState(
      stateRendererType: RendrerStateType.popupErorrState,
      message: failure.message,
    ));
                }, // to dismiss the dialogs I have used content state as the extension dismiss before building the content
            (data) {
              isUserLoggedinSuccessfullyStreamController.add(true);
                  stateInput.add(ContentState());
                  _appPreferences.userLoggedIn();

});
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
