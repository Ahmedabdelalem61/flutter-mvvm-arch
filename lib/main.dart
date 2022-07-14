import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/App/app.dart';
import 'package:flutter_mvvm_app/Presentation/resources/language_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'App/dependency_injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp( EasyLocalization(child: Phoenix(child: MyApp()), supportedLocales: const [ARABIC_LOCAL,ENGLISH_LOCAL], path: LOCALISATIONS_PATH));
}

