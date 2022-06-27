import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/App/app_prefs.dart';
import 'package:flutter_mvvm_app/App/dependency_injection.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Presentation/resources/routes_manager.dart';
import '../Presentation/resources/theme_manager.dart';
class MyApp extends StatefulWidget {
  MyApp._interanl();
  static final MyApp _instance = MyApp._interanl();
  factory MyApp()=>_instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppPreferences _appPreferences= dIinstance<AppPreferences>(); 
  
  
  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
