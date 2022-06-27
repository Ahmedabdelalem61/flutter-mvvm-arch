import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/Presentation/resources/font_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/styles_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/values_manager.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,

    // cardView theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
        elevation: AppSize.s4,
        shadowColor: ColorManager.lightPrimary,
        color: ColorManager.primary,
        centerTitle: true,
        titleTextStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16)),

    // button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.white, fontSize: FontSize.s17),
            primary: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    // text theme
    textTheme: TextTheme(
        displayLarge: getSemiBoldStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s16),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s16),
        headlineMedium: getRegularStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s14),
        titleMedium: getMediumStyle(
            color: ColorManager.primary, fontSize: FontSize.s16),
        titleSmall: getRegularStyle(
            color: ColorManager.primary, fontSize: FontSize.s12),
        bodySmall: getRegularStyle(color: ColorManager.grey1),
        bodyLarge: getRegularStyle(color: ColorManager.grey),
        bodyMedium: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s18),
        labelSmall: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s16),
        titleLarge: getRegularStyle(color: ColorManager.grey2, fontSize: FontSize.s12),

        ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
        getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        labelStyle:
        getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
  );
}
