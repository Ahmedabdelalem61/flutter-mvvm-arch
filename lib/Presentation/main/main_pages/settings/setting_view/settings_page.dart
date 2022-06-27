import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/App/app_prefs.dart';
import 'package:flutter_mvvm_app/App/dependency_injection.dart';
import 'package:flutter_mvvm_app/Data/data_source/local_data_sourece.dart';
import 'package:flutter_mvvm_app/Presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/language_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/values_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as mth;

import '../../../../resources/color_manager.dart';
import '../../../../resources/routes_manager.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final AppPreferences _sharedPreferences = dIinstance<AppPreferences>();
  final LocalDataSource _localDataSource = dIinstance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(children: [
        ListTile(
          leading: SvgPicture.asset(ImageAssets.changeLangIcon),
          title: const Text(
            AppStrings.changeLang,
          ).tr(),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_isFromRightToLeft() ? mth.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowIc,color: ColorManager.primary),
          ),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.contactUsIcon),
          title: const Text(
            AppStrings.contact,
          ).tr(),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_isFromRightToLeft() ? mth.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowIc,color: ColorManager.primary),
          ),
          onTap: () {
            _contactUS();
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.inviteFriends),
          title: const Text(
            AppStrings.inviteFriends,
          ).tr(),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_isFromRightToLeft() ? mth.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowIc,color: ColorManager.primary),
          ),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.logoutIcon),
          title: const Text(AppStrings.logout).tr(),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_isFromRightToLeft() ? mth.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowIc,color: ColorManager.primary),
          ),
          onTap: () async {
            await _logout();
          },
        )
      ]),
    );
  }

  bool _isFromRightToLeft() {
    return context.locale == ARABIC_LOCAL;
  }

  _changeLanguage() {
    //localization
    _sharedPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUS() {
    //todo: web view navigation using determined url
  }

  _inviteFriends() {
    //todo: use 3rd party package to invite
  }

  Future<void> _logout() async {
    //clear data from cache
    _localDataSource.clearCache();
    //clear that you have logged to navigate to login while starting the app
    await _sharedPreferences.logout();
    Navigator.of(context).pushNamed(Routes.loginRoute);
  }
}
