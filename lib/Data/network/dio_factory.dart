import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_app/App/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../App/app_prefs.dart';

class DioFactory {

  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);


  final int _timeout = 60 * 1000;


  Future<Dio> getDio() async {
    String language = await _appPreferences.getAppLanguage();
    final Map<String, String> _headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': Constants.token,
      'language': language,
    };
    Dio dio = Dio();
    dio.options = BaseOptions(
      headers: _headers,
      receiveTimeout: Constants.apiTimeOut,
      sendTimeout: Constants.apiTimeOut,
      baseUrl: Constants.baseUrl,
    );

    if(!kReleaseMode){
      dio.interceptors.add(PrettyDioLogger(
        requestHeader : true,
        requestBody : true,
        responseHeader : true,));
    }
    return dio;
  }
}
