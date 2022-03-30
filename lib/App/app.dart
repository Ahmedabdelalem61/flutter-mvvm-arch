import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
