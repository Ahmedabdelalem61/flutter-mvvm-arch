import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/App/app_prefs.dart';
import 'package:flutter_mvvm_app/App/dependency_injection.dart';
import 'package:flutter_mvvm_app/Data/data_source/local_data_sourece.dart';
import 'package:flutter_mvvm_app/Presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/values_manager.dart';
import 'package:flutter_svg/svg.dart';

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
          ),
          trailing: SvgPicture.asset(ImageAssets.rightArrowIc),
          onTap: () {_changeLanguage();},
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.contactUsIcon),
          title: const Text(
            AppStrings.contact,
          ),
          trailing: SvgPicture.asset(ImageAssets.rightArrowIc),
          onTap: () {_contactUS();},
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.inviteFriends),
          title: const Text(
            AppStrings.inviteFriends,
          ),
          trailing: SvgPicture.asset(ImageAssets.rightArrowIc),
          onTap: () {_inviteFriends();},
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.logoutIcon),
          title: const Text(AppStrings.logout),
          trailing: SvgPicture.asset(ImageAssets.rightArrowIc),
          onTap: () async{await _logout();},
        ),
      ]),
    );
  }
  _changeLanguage(){
    //localization
  }

  _contactUS(){
    //todo: web view navigation using determined url
  }

  _inviteFriends(){
    //todo: use 3rd party package to invite
  }

  Future<void> _logout()async{
    //clear data from cache
     _localDataSource.clearCache();
    //clear that you have logged to navigate to login while starting the app
    await _sharedPreferences.logout();
  }
}
