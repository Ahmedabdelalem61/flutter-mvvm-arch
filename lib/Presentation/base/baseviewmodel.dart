abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  //for any shared methods or variables for  views
}

abstract class BaseViewModelInputs{
  void start();// start the jop for the base view model;
  void dispose();//make the class die after disposing
}

abstract class BaseViewModelOutputs{
}
