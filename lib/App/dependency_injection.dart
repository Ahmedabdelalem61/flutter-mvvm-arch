import 'package:dio/dio.dart';
import 'package:flutter_mvvm_app/App/app_prefs.dart';
import 'package:flutter_mvvm_app/Data/data_source/remote_data_source.dart';
import 'package:flutter_mvvm_app/Data/network/app_api.dart';
import 'package:flutter_mvvm_app/Data/repository/repository_imp.dart';
import 'package:flutter_mvvm_app/Domain/usecase/login_usecase.dart';
import 'package:flutter_mvvm_app/Presentation/login/view_model/login_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/network/dio_factory.dart';
import '../Data/network/network_info.dart';
import '../Domain/repository/repository.dart';

final dIinstance = GetIt.instance;

Future<void> initAppModule()async{
  final sharedPreferences = await SharedPreferences.getInstance();

  //app prefs
  dIinstance.registerLazySingleton<SharedPreferences>(() =>sharedPreferences);
  dIinstance.registerLazySingleton<AppPreferences>(() =>AppPreferences( dIinstance<SharedPreferences>()));

  // network info
  dIinstance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  dIinstance.registerLazySingleton<DioFactory>(() => DioFactory(dIinstance()));

  Dio dio = await dIinstance<DioFactory>().getDio();
  //app service client
  dIinstance.registerLazySingleton<AppServicesClient>(() => AppServicesClient(dio));

  // remote data source
  dIinstance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImp(dIinstance<AppServicesClient>()));

  // repository

  dIinstance.registerLazySingleton<Repository>(
          () => RepositoryImp(dIinstance(), dIinstance()));
}

initLoginModule(){
 // if registered once in the app we needn't a lot
  if(!GetIt.I.isRegistered<LoginUseCase>()){
   //login useCase
   dIinstance.registerFactory<LoginUseCase>(() => LoginUseCase(dIinstance()));
   //login ViewModel
   dIinstance.registerFactory<LoginViewModel>(() => LoginViewModel(dIinstance()));
 }

}