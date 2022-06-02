import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/App/app.dart';
import 'App/dependency_injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp( MyApp());
}

