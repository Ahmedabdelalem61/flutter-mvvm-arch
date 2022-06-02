import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_rendrer.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';

import '../../../App/constants.dart';

abstract class FlowState {
  RendrerStateType getStateType();
  String getMessage();
}

class LoadingState implements FlowState {
  RendrerStateType stateType;
  String message;
  LoadingState({this.message = AppStrings.loading, required this.stateType});

  @override
  String getMessage() => message;

  @override
  RendrerStateType getStateType() => stateType;
}

// error state (POPUP,FULL SCREEN)
class ErrorState extends FlowState {
  RendrerStateType stateRendererType;
  String message;

  ErrorState({required this.stateRendererType,required this.message});

  @override
  String getMessage() => message;

  @override
  RendrerStateType getStateType() => stateRendererType;
}

// content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  RendrerStateType getStateType() => RendrerStateType.contentState;
}

// EMPTY STATE

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  RendrerStateType getStateType() => RendrerStateType.fullEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateType() == RendrerStateType.popupLoadingState) {
            showPopUp(context, getStateType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateType: getStateType(),
                title: "title",
                message: getMessage(),
                retryFunctionRenderer: retryActionFunction);
          }
        }
      case ErrorState:
          dismissDialog(context);
        {
          if (getStateType() == RendrerStateType.popupErorrState) {
            showPopUp(context, getStateType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateType: getStateType(),
                title: "title",
                message: getMessage(),
                retryFunctionRenderer: retryActionFunction);
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          dismissDialog(context);
          return StateRenderer(
              stateType: getStateType(),
              title: "title",
              message: getMessage(),
              retryFunctionRenderer: () {});
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

 _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopUp(
    BuildContext context,
    RendrerStateType stateType,
    String message,
  ) {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateType: stateType,
            title: "title",
            message: message,
            retryFunctionRenderer: () {}),
      ),
    );
  }
}
