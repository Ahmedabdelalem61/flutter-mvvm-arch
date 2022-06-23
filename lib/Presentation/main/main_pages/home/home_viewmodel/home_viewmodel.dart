import 'dart:async';
import 'dart:ffi';

import 'package:flutter_mvvm_app/Domain/models/models.dart';
import 'package:flutter_mvvm_app/Domain/usecase/home_usecase.dart';
import 'package:flutter_mvvm_app/Presentation/base/baseviewmodel.dart';
import 'package:rxdart/subjects.dart';

import '../../../../common/state_rendrer/state_renderer_imp.dart';
import '../../../../common/state_rendrer/state_rendrer.dart';

class HomeViewModel extends BaseViewModel
    with InputHomeViewModel, OutputHomeViewModel {
  StreamController servicesStreamController = BehaviorSubject<List<Service>>();
  StreamController banneresStreamController = BehaviorSubject<List<BannerAds>>();
  StreamController storesStreamController = BehaviorSubject<List<Store>>();

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
    servicesStreamController.close();
    banneresStreamController.close();
    storesStreamController.close();
    super.dispose();
  }

  _getHomeData() async {
    stateInput.add(LoadingState(
        stateType: RendrerStateType.fullErrorState,
        message: "wait for seconds.",
        title: 'loading...'));

    (await _homeUseCase.execute(Void)).fold((failure) {
      stateInput.add(ErrorState(
        stateRendererType: RendrerStateType.fullErrorState,
        message: failure.message,
      ));
    }, // to dismiss the dialogs I have used content state as the extension dismiss before building the content
        (HomeData) {
          inputBanners.add(HomeData.data.banners);
          inputServices.add(HomeData.data.services);
          inputStores.add(HomeData.data.stores);
          stateInput.add(ContentState());
        });
  }

  @override
  Sink get inputBanners => banneresStreamController.sink;

  @override
  Sink get inputServices => servicesStreamController.sink;

  @override
  Sink get inputStores => storesStreamController.sink;

  @override
  Stream<List<BannerAds>> get outputBanneres =>
      banneresStreamController.stream.map((banneres) => banneres);

  @override
  Stream<List<Service>> get outputServices =>
      servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      storesStreamController.stream.map((stores) => stores);
}

// input and output home viewmodels
abstract class InputHomeViewModel {
  Sink get inputServices;
  Sink get inputStores;
  Sink get inputBanners;
}

abstract class OutputHomeViewModel {
  Stream<List<Service>> get outputServices;
  Stream<List<Store>> get outputStores;
  Stream<List<BannerAds>> get outputBanneres;
}
