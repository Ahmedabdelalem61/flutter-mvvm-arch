
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

enum RendrerStateType {
  //full rendrer
  fullLoadingState,
  fullErrorState,
  fullEmptyState,
  fullSuccessState,
  // general
  contentState,

  // pop up renderer
  popupErorrState,
  popupLoadingState,
  popupSuccessState,
}

class StateRenderer extends StatelessWidget {
  RendrerStateType stateType;
  String message;
  String title;
  Function retryFunctionRenderer;

  StateRenderer(
      {Key? key,
      required this.stateType,
      required this.title,
      required this.message,
      required this.retryFunctionRenderer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getRenderedWidget(context);
  }

  Widget _getRenderedWidget(BuildContext context) {
    switch (stateType) {
      case RendrerStateType.fullLoadingState:
         return _getColumnWidgets([_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case RendrerStateType.fullErrorState:
          return _getColumnWidgets([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain,context),
        ]);
      case RendrerStateType.fullEmptyState:
      return _getColumnWidgets([_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      case RendrerStateType.contentState:
        return Container();
      case RendrerStateType.popupErorrState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);
      case RendrerStateType.popupLoadingState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.loading),
              _getTitle(title),
              _getMessage(message),
        ]);
      case RendrerStateType.popupSuccessState:
      return _getPopUpDialog(context,
            [
              _getAnimatedImage(JsonAssets.success),
              _getTitle(title),
              _getMessage(message),
              _getRetryButton(AppStrings.ok, context),
            ],);
      case RendrerStateType.fullSuccessState:
      return _getColumnWidgets([_getAnimatedImage(JsonAssets.success),_getMessage(message)]);
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return   Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.transparent,
      elevation: AppSize.s1_5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        ),
        child:  _getDialogContent(context, children),
        
      ) ,
    );
  }
Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
  Widget _getColumnWidgets(List<Widget> widgets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName)
    ) ;
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Text(
          message,
          style: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s18),
        ),
      ));
  }

   Widget _getTitle(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          title,
          style: getMediumStyle(
              color: ColorManager.black, fontSize: FontSize.s18),
        ),
      ));
  }


    Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (stateType ==
                      RendrerStateType.fullErrorState) {
                    // call retry function
                    retryFunctionRenderer.call();
                  } else {
                    // popup error state
                    Navigator.of(context).pop();
                  }
                },
                child: Text(buttonTitle).tr())),
      ),
    );
  }
}
