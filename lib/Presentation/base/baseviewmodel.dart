import 'dart:async';

import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_renderer_imp.dart';
import 'package:rxdart/subjects.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  //for any shared methods or variables for  views
  final StreamController<FlowState> _flowStateController  = BehaviorSubject<FlowState>();
  @override
  void dispose() {
    _flowStateController.close();
  }

  @override
  Sink get stateInput => _flowStateController.sink;

  @override
  Stream<FlowState> get stateOutput =>_flowStateController.stream.map((FlowState) => FlowState);

}

abstract class BaseViewModelInputs{
  Sink get stateInput;
  void start();// start the jop for the base view model;
  void dispose();//make the class die after disposing
}

abstract class BaseViewModelOutputs{
  Stream<FlowState> get stateOutput;
}
