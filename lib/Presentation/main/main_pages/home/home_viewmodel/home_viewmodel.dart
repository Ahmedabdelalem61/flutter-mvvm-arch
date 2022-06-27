import 'dart:async';
import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mvvm_app/Domain/models/models.dart';
import 'package:flutter_mvvm_app/Domain/usecase/home_usecase.dart';
import 'package:flutter_mvvm_app/Presentation/base/baseviewmodel.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';
import 'package:rxdart/subjects.dart';

import '../../../../common/state_rendrer/state_renderer_imp.dart';
import '../../../../common/state_rendrer/state_rendrer.dart';

class HomeViewModel extends BaseViewModel
    with InputHomeViewModel, OutputHomeViewModel {

  StreamController homeViewdataStreamController = BehaviorSubject<HomeViewData>();

  // if u don't know about behavior subject it's subtype of streams u can search about :)
  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);
  @override
  void start() {
    //call the api
    _getHomeData();
  }
  @override
  void dispose() {
    homeViewdataStreamController.close();
    super.dispose();
  }

  _getHomeData() async {
    stateInput.add(LoadingState(
        stateType: RendrerStateType.fullErrorState,
        message: AppStrings.loadingMessage.tr(),
        title: AppStrings.loading.tr()));

    (await _homeUseCase.execute(Void)).fold((failure) {
      stateInput.add(ErrorState(
        stateRendererType: RendrerStateType.fullErrorState,
        message: failure.message,
      ));
    }, // to dismiss the dialogs I have used content state as the extension dismiss before building the content
        (HomeData) {
          inputHomeViewData.add(HomeViewData(banners: HomeData.data.banners, services: HomeData.data.services, stores: HomeData.data.stores));
          stateInput.add(ContentState());
        });
  }
  
  @override
  Sink get inputHomeViewData => homeViewdataStreamController.sink;
  
  @override
  Stream<HomeViewData> get outputHomeViewData => homeViewdataStreamController.stream.map((homeViewData) => homeViewData);
  }


// input and output home viewmodels
abstract class InputHomeViewModel {
  Sink get inputHomeViewData;

}

abstract class OutputHomeViewModel {
  Stream<HomeViewData> get outputHomeViewData;
}
